#!/bin/sh
 
# 01/2018
# christian.pottier@univ-angers.fr
#  
# pre clonage ou remastersys ...

#Initialisation de la 1ére connection
if [ -f /etc/rc.local ]; then
	sudo cp /etc/rc.local /etc/rc.local.svg
fi
sudo cp -f /etc/post_clone.sh /etc/rc.local
sudo chmod +x /etc/rc.local
# vide dhclient
sudo rm /var/lib/NetworkManager/dhclient-*.lease

echo -n "Vous pouvez maintenant lancer le clonage ou remastersys ..."
read tempo
