#!/bin/sh
 
# 08/2020
# christian.pottier@univ-angers.fr
# 25/10/2022 mise à jour non interactiv
# 22/08/2024 suppression maj youtube-dl

echo 'MaMaj : Script pour la mise à jour de votre Debian'
echo ' + mises à jour de youtube-dl + ...'

echo 'Mise à jour de la liste des paquets :'
echo 'sudo apt update -y --allow-releaseinfo-change'
sudo apt update -y --allow-releaseinfo-change

echo 'Mise à jour des paquets :'
echo 'sudo apt full-upgrade -y'
sudo apt full-upgrade -y
#sudo DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" full-upgrade -y


#~ if ( sudo apt-cache policy gyt-dl | grep Installé ) ; then
	#~ if ! ( sudo apt-cache policy gyt-dl | grep Installé | grep -q aucun ) ; then
		#~ echo 'Mise à jour youtube-dl :'
		#~ echo 'sudo youtube-dl -U'
		#~ sudo youtube-dl -U
	#~ fi
#~ fi

if ( sudo apt-cache policy microsoft-edge-stable | grep Installé ) ; then
	echo "Force priorité microsoft-edge-stable à 10"
	sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/microsoft-edge-stable 10
	sudo update-alternatives --auto x-www-browser
	sudo update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/microsoft-edge-stable 10
	sudo update-alternatives --install /usr/bin/microsoft-edge microsoft-edge /usr/bin/microsoft-edge-stable 10
fi
echo 'Fin ...'
