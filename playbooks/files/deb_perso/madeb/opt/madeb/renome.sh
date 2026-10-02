#!/bin/sh
 
# 01/2010
# christian.pottier@univ-angers.fr
#  
# renome le poste après clonage
# 09/01/2018 Debian 9

# PARAMETRES :
oldhost=`hostname -s`
echo Nom de la machine $oldhost
echo -n Nouveau nom :
read newhost
if [ -z $newhost ]; then
	exit 1
fi
echo Renome la machine $oldhost en $newhost
sudo hostnamectl set-hostname $newhost
hostnamectl
# Si ça suffit pas :
sudo sed -i -e "s/$oldhost/$newhost/g" /etc/hosts
sudo sed -i -e "s/$oldhost/$newhost/g" /etc/hostname

cat /etc/hosts

echo -n Redemarrage du système $newhost ...
read tempo

sudo reboot
