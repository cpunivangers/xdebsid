#!/bin/sh

# 11/2014
# christian.pottier@univ-angers.fr
#
# Vérif. UUID swap suite à modif de la partition
# 01/02/2018 ajout update-initramfs
# 16/10/2018 ajout UUID pour disque ssd

sudo swapon -s

OLD_UUID_SWAP=`cat /etc/fstab | grep UUID= | grep swap | cut -d\  -f1 | cut -d= -f2`
#16/10/2018#NEW_UUID_SWAP=`sudo blkid | grep '/dev/s' | grep swap | cut -d\" -f2`
NEW_UUID_SWAP=$(sudo blkid | grep 'TYPE="swap"' | cut -d\" -f2)

if [ "$OLD_UUID_SWAP" = "$NEW_UUID_SWAP" ]; then
	exit 0
fi
# maj UUID swap dans fstab
sudo sed -i -e "s/UUID=$OLD_UUID_SWAP/UUID=$NEW_UUID_SWAP/" /etc/fstab
echo "fstab maj"

# maj pour hibernation
sudo sed -i -e "s/UUID=$OLD_UUID_SWAP/UUID=$NEW_UUID_SWAP/" /etc/initramfs-tools/conf.d/resume
echo "Hibernation maj"
sudo update-initramfs -u

# maj grub
# actualise les périphériques
sudo grub-mkdevicemap
echo "périphériques actualisés"
# Recherche autres os
sudo os-prober
echo "os-prober"
# maj grub
sudo update-grub
echo "grub maj"