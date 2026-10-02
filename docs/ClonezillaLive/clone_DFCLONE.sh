#!/bin/sh
 
# 10/2023
# christian.pottier@univ-angers.fr
# Clonnage clé DFCLONE

#~ if [ "$(id -u)" != "0" ]; then
	#~ echo "Sorry, you are not root."
	#~ echo "sudo $0 ou sudo -i"
	#~ exit 1
#~ fi
if [ ! -d "/media/bonjour/DFCLONE/home/partimag/DF-img" ];then
	echo "Le dossier /media/bonjour/DFCLONE/home/partimag/DF-img n'existe pas !";
	exit 1
fi
echo "ATTENTION !!! Création de table de partition sur la clé cible /dev/sdc .."
echo -n "Accord (O/..) :"
read ACCORD
if [ -z $ACCORD ] ; then exit ; fi
if [ "$ACCORD" != "O" ] ; then exit ; fi

sudo parted -s /dev/sdc mklabel msdos
echo "Création de la partition ..."
sudo parted -s /dev/sdc mkpart primary fat32 0% 100%
echo "Formatage de la partition DFCLONE ..."
sudo mkfs.vfat -n DFCLONE /dev/sdc1
echo "Montage de la clé cible ..."
udisksctl mount -b /dev/sdc1
echo "rsync -av --progress /media/bonjour/DFCLONE/ /media/bonjour/DFCLONE1/" 
rsync -av --progress /media/bonjour/DFCLONE/ /media/bonjour/DFCLONE1/
echo "Faire la clé bootable ..."
sudo bash /media/bonjour/DFCLONE1/utils/linux/makeboot.sh -b /dev/sdc1
echo "Démontage de la clé ..."
udisksctl unmount -b /dev/sdc1
