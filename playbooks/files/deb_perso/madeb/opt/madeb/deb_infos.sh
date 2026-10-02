#!/bin/sh
 
# 04/2015

# 27/05/2015 nom os avec /etc/os-release
# 08/2017 debian 9
# 10/2019 devbian 10

echo "Détection du system .."
if [ -r /etc/os-release ]; then
	. /etc/os-release
	NOM_OS="$ID"
else
	echo "distribution /etc/os-release absent"
	exit
fi
#NOM_OS=`lsb_release -is`
CODE_OS=`lsb_release -cs`
## Environnement de bureau principal
ENV_OS="Gnome"
ENV_GNOME="n"
ENV_LXDE="n"
ENV_LXFCE="n"

if [ "$NOM_OS" = "ubuntu" ] ; then
	if ! ( sudo apt-cache policy lubuntu-desktop | grep Installé | grep -q aucun ) ; then
		ENV_OS="Lxde"
	fi
else
	if ! ( sudo apt-cache policy lxde | grep Installé | grep -q aucun ) ; then
		ENV_OS="Lxde"
	else
		if ! ( sudo apt-cache policy xfce4 | grep Installé | grep -q aucun ) ; then
			ENV_OS="Xfce"
			ENV_LXFCE="y"
		fi
	fi
fi
## Environnement secondaire
if [ "$ENV_OS" = "Gnome" ] ; then
	ENV_GNOME="y"
	ENV_LXDE="n"
	if ! ( sudo apt-cache policy lxde-core | grep Installé | grep -q aucun ) ; then
		ENV_LXDE="y"
	fi
else
	if [ "$ENV_OS" = "Lxde" ] ; then
		ENV_GNOME="n"
		ENV_LXDE="y"
		if ! ( sudo apt-cache policy gnome-core | grep Installé | grep -q aucun ) ; then
			ENV_GNOME="y"
		fi
	else
		if ! ( sudo apt-cache policy gnome-core | grep Installé | grep -q aucun ) ; then
			ENV_GNOME="y"
		fi		
	fi
fi
##
sudo laptop-detect
TYPE_HW=$?
if [ "$TYPE_HW" = "1" ] ; then
	TYPE_HW="Desktop"
else
	TYPE_HW="Laptop"
fi
TYPE_ARCH=$(dpkg --print-architecture)

FABRICANT=`sudo dmidecode -s system-manufacturer`
MODEL=`sudo dmidecode -s system-product-name`
NUMSERIE=`sudo dmidecode -s system-serial-number`

echo `lsb_release -d`
echo $NOM_OS $CODE_OS $ENV_OS $TYPE_HW $TYPE_ARCH Gnome:$ENV_GNOME Lxde:$ENV_LXDE Xfce:$ENV_LXFCE
echo $FABRICANT $MODEL
echo "Numéro de série : $NUMSERIE"
echo "Ethernet :"
sudo ip a

echo "Mise à jour de sécurité :"
grep -i security /etc/apt/apt.conf.d/50unattended-upgrades
grep -i unattended /etc/apt/apt.conf.d/*periodic

echo "Utilisateurs en-cours"
# who
# pb avec debian 7 xfce who ne marche pas ???
#ck-list-sessions | grep realname | cut -d\' -f2
# ou ck-history --last-compat|grep still
# Debian 9 a verifier
#loginctl list-users
who
# debian 9 ? echo "Frequence Utilisateurs"
#ck-history --frequent
# debian 9 ?
echo "Dernière mise à jour avec madeb :"
dpkg-query -W madeb
#tail -1 /var/log/deb10.log

echo "Dernière mise à jour du système :"
ls -lu /var/cache/apt/pkgcache.bin

exit
