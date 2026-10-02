#!/bin/bash
 
# 22/09/2025
# christian.pottier@univ-angers.fr
#  
# XDEB12 to XDEB13
# curl -sL https://raw.githubusercontent.com/cpunivangers/madeb13/main/playbooks/files/Divers/xdeb12toxdeb13.sh | bash

#~ # test bash
if [ -z $BASH ]; then
	echo "Lancer avec bash !"
	exit 1
fi

echo "🟡 Mise à jour de Debian 12 vers Debian 13 (Trixie)"

echo "📦 Version actuelle :"
head -4 /etc/os-release

sudo apt -y purge madeb
sudo rm -rf /opt/madeb
sudo rm -rf /opt/deb_perso
sudo rm -rf /opt/ansible/*

echo "🚫 Suppression des paquets pouvant poser pb"
#~ sudo apt -y purge virtualbox-6.1
if ! ( sudo apt-cache policy ntpdate | grep Installé | grep -q aucun ) ; then
	echo "Suppression ntpdate..."
	sudo apt-get -y purge ntpdate
fi
if ! ( sudo apt-cache policy parcellite | grep Installé | grep -q aucun ) ; then
	echo "Suppression parcellite..."
	sudo apt-get -y purge parcellite
fi
if ! ( sudo apt-cache policy libdvd-pkg | grep Installé | grep -q aucun ) ; then
	echo "Suppression libdvd-pkg..."
	sudo apt -y purge libdvd-pkg
fi
if ! ( sudo apt-cache policy pipewire | grep Installé | grep -q aucun ) ; then
	echo "Suppression pipewire*... pour retour à pulseaudio"
	sudo apt -y purge pipewire*
fi
if  ( dpkg --get-selections | grep -qn ":i386" ) ; then
	echo "Suppression paquets i386..."
	sudo apt -y purge ".*:i386"
	sudo dpkg --remove-architecture i386
fi

echo "🔄 Mise à jour du système actuel (Debian 12)..."
sudo apt update -y --allow-releaseinfo-change
sudo -v
sudo apt full-upgrade -y

echo "🧼 Nettoyage du système actuel..."
sudo apt clean
sudo apt autoclean
sudo apt autoremove -y

sudo rm -rf /etc/apt/sources.list.d11
if [ ! -z "$(ls -A /etc/apt/sources.list.d)" ]; then
	echo "💾 Sauvegarde de /etc/apt/sources.list.d vers sources.list.d12"
	sudo mv /etc/apt/sources.list.d /etc/apt/sources.list.d12
fi
echo "✏️ Mise à jour des dépôts APT vers Debian 13"
#sed -i 's/bookworm/trixie/g' /etc/apt/sources.list
cat << EOF | sudo tee /etc/apt/sources.list
# debian trixie sources.list
deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
#deb http://deb.debian.org/debian/ trixie-proposed-updates main contrib non-free non-free-firmware
deb http://deb.debian.org/debian/ trixie-backports main contrib non-free non-free-firmware
EOF

echo "🆕 Mise à jour de la liste des paquets Debian 13..."
sudo apt update -y --allow-releaseinfo-change

# Espace disque nécessaire
sudo apt full-upgrade --assume-no
df -h /

echo "Avez-vous l'espace suffisant pour effectuer cette mise à jour ?"
echo -n "Continuer ... (ou faire CTRL+C pour arrêter le script)" ; read tempo

#~ echo "🧩 Upgrade partiel sans nouveaux paquets..."
#~ sudo apt upgrade --without-new-pkgs -y
 
echo "⚙️ Mise à niveau complète..."
sudo DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade -y

echo "🧼 Nettoyage..."
sudo apt -f install -y
sudo apt autoremove --purge -y
sudo apt clean
sudo apt autoclean
# Suppression des fichiers config restant
#~ sudo apt list '~c'
sudo apt purge '~c' -y

echo "✅ Version après mise à jour :"
head -4 /etc/os-release

echo "⚙️ Téléchargement et installation madeb13..."
echo -n "Continuer ... (ou faire CTRL+C pour arrêter le script)" ; read tempo

# bug deb13 ancienne version panel xfce cpugraph...
sudo find /home -path '*/.config/xfce4/panel/*.rc' -type f -exec rm -f {} \;
sudo find /etc/skel -path '*/.config/xfce4/panel/*.rc' -type f -exec rm -f {} \;

# téléchargement de madeb13
curl -sL curl -sL https://raw.githubusercontent.com/cpunivangers/madeb13/main/update_madeb13.sh > update_madeb13.sh

bash update_madeb13.sh download

# installation madeb13 en forcant update
rm -f /opt/ansible/madeb13/Version.txt
bash /opt/ansible/madeb13/update_madeb13.sh
