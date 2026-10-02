#!/bin/sh -e

# 08/2018
# christian.pottier@univ-angers.fr
#
#26/11/2018 recup nom avec dhcp
# post clonage 1er demarrage

FICHLOG="/var/log/postclone.log"
echo "post clone `date`" >> $FICHLOG

# on supprime la tache au demarrage
if [ -f /etc/rc.local.svg ]; then
	cp -f /etc/rc.local.svg /etc/rc.local
	chmod -x /etc/rc.local
else
	rm /etc/rc.local
fi
echo "Tache demarrage supprimée" >> $FICHLOG

# maj config grub 2 aprés restauration
NOM_OS=`lsb_release -is`
#if [ "$NOM_OS" = "HandyLinux" ] ; then
#	NOM_OS="Debian"
#fi
if [ "$NOM_OS" = "Debian" ] ; then
	# Cache grub impossible avec possibilité d'affichage à la demande -> timeout=2
	sed -i -e 's/GRUB_TIMEOUT=.*$/GRUB_TIMEOUT=2/' /etc/default/grub
fi
# actualise les périphériques
grub-mkdevicemap
echo "périphériques actualisés" >> $FICHLOG
# Recherche autres os
os-prober
echo "os-prober" >> $FICHLOG
# maj grub
update-grub
echo "grub maj" >> $FICHLOG

# Re-init carte réseau
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
	echo "rm /etc/udev/rules.d/70-persistent-net.rules" >> $FICHLOG
	rm /etc/udev/rules.d/70-persistent-net.rules
fi
if [ -f /etc/NetworkManager/NetworkManager.conf ]; then
	echo "sed -i /no-auto-default/d" >> $FICHLOG
	sed -i "/no-auto-default/d" /etc/NetworkManager/NetworkManager.conf
fi
if [ -e /etc/NetworkManager/system-connections ]; then
	if [ ! $(ls -a /etc/NetworkManager/system-connections/|wc -l) = 2 ]; then
		# non vide
		echo "rm /etc/NetworkManager/system-connections/*" >> $FICHLOG
		rm /etc/NetworkManager/system-connections/*
	fi
fi
echo "carte réseau re-init" >> $FICHLOG
# Suppression remastersys
#apt-get remove -y --purge remastersys

OLDHOST=`hostname -s`
echo "Nom du poste : $OLDHOST" >> $FICHLOG

#on récupère le nouveau nom de la machine dans le fichier clone.txt / numero de série du poste
# Fichier /etc/clone.txt :	Nom;AdresseMac;AdresseIP ou DHCP;Groupe;No Série
NUMSERIE=`dmidecode -s system-serial-number`
echo "Numéro de série : $NUMSERIE" >> $FICHLOG
NEWHOST=""
NEWIP="DHCP"
NEWGROUP=""
if [ ! "$NUMSERIE" = "0" ]; then
	if [ -f /etc/clone.txt ] ; then
		NEWHOST=`cat /etc/clone.txt | grep -i ";$NUMSERIE" | cut -f1 -d";"`
		NEWIP=`cat /etc/clone.txt | grep -i ";$NUMSERIE" | cut -f3 -d";"`
		NEWGROUP=`cat /etc/clone.txt | grep -i ";$NUMSERIE" | cut -f4 -d";"`
	fi
	if [ -z $NEWHOST ]; then
		# recup du dhcp
		DHCPLEASE=$(ps auxww | grep -- "-lf .*\.lease" | grep -v grep | grep -v sed | sed 's{^.*-lf \(.*\.lease\).*{\1{')
		NEWHOST=$(grep "option host-name" $DHCPLEASE | cut -d\" -f2)
	fi
	if [ -z $NEWHOST ]; then
		NEWHOST="pc$NUMSERIE"
	fi
	echo "`date` $OLDHOST -> $NEWHOST" >> $FICHLOG
	if [ ! -z $NEWHOST ]; then
		#renomme la machine par son nouveau nom
		hostnamectl set-hostname $NEWHOST
		# si ça suffit pas :
		sed -i "s/$OLDHOST/$NEWHOST/g" /etc/hosts
		sed -i "s/$OLDHOST/$NEWHOST/g" /etc/hostname
		echo "Nouveau nom : $NEWHOST" >> $FICHLOG
	fi
	if ! ( apt-cache policy virtualbox-guest-utils | grep Installé | grep -q aucun ) ; then
		echo "Suppression virtualbox-guest-*" | sudo tee -a $FICHLOG
		apt-get -y remove virtualbox-guest-*
	fi
	#~ if [ -e /var/lib/fusioninventory-agent ] ; then
		#~ rm -rf /var/lib/fusioninventory-agent
	#~ fi
fi

# Config réseau
FICHINTERFACES="/etc/network/interfaces"
printf "auto lo\niface lo inet loopback\n\n" > $FICHINTERFACES
echo "Initialisation /etc/network/interfaces" >> $FICHLOG
if [ -f /etc/clone_ip.txt ]; then
	# Configuration fixe => ajouter applet dans tableau de bord "gnome-netstatut-applet" pour remplacer network-manager
	NOMETH=$(ls /sys/class/net/ | grep "en")
	if [ -z $NOMETH ]; then
		NOMETH="eth0"
	fi
	if [ "$NEWIP" = "DHCP" ]; then
		printf "auto $NOMETH\niface $NOMETH inet dhcp\n" >> $FICHINTERFACES
	else
		printf "auto $NOMETH\niface $NOMETH inet static\n\taddress $NEWIP" >> $FICHINTERFACES
		cat /etc/clone_ip.txt >> $FICHINTERFACES
	fi
	echo "`date` $FICHINTERFACES $NOMETH $NEWIP" >> $FICHLOG
fi
# Script de config réseau
if [ -f /etc/conf_IP.txt ]; then
	if [ ! -z $NEWIP ]; then
		CONF_IP=`cat /etc/conf_IP.txt | grep -i "$NEWIP"`
		if [ ! -z "$CONF_IP" ]; then
			# script de conf
			sh $CONF_IP
		fi
	fi
fi

#Groupe samba
echo "Groupe samba = $NEWGROUP" >> $FICHLOG
if [ ! -z "$NEWGROUP" ]; then
	sed -i "/^   workgroup = /c \   workgroup = $NEWGROUP" /etc/samba/smb.conf
	echo "`date` workgroup $NEWGROUP" >> $FICHLOG
fi

OLD_LOGIN=$(id -un -- 1000)
echo "$OLD_LOGIN" >> $FICHLOG
if [ "$OLD_LOGIN" = "oem" -o "$OLD_LOGIN" = "bonjour" ]; then
	echo "oem-install" >> $FICHLOG
	sh /opt/ansible/madeb13/playbooks/files/oem-install/pre_oem-install.sh
fi

#on redemarre la machine
echo "reboot" >> $FICHLOG

systemctl reboot

exit 0
