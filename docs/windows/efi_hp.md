# HP

## Boot UEFI

### Visualiser EFI

	sudo efibootmgr -v

### Sauvegarde boot windows
	sudo cp /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi /boot/efi/EFI/Microsoft/Boot/windows.efi

### Copie du boot debian à la place
	sudo cp /boot/efi/EFI/debian/grubx64.efi /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi

### Ajout Windows dans grub

## script pour post maj kernel

	echo -e '#! /bin/sh\n\nset -e\n\nsed -i -e "s/item_in_dir bootmgfw.efi/item_in_dir windows.efi/" /usr/lib/os-probes/mounted/efi/20microsoft\n\nexit 0' | tee /tmp/za-windows-hp
	sudo install /tmp/za-windows-hp /etc/kernel/postinst.d/za-windows-hp
	sudo /etc/kernel/postinst.d/za-windows-hp


## Pb boot live DF sur HP EliteBook 850 G8  

Message :

	out of memory

Dans le BIOS, réduire la taille de la mémoire vidéo à 256 Go maxi !

Le problème persiste avec un clé usb live ubuntu !