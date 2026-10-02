# Clé de licence Windows dans le BIOS



## Affichage

	sudo tail -c +56 /sys/firmware/acpi/tables/MSDM

## dans une VM Virtualbox

[https://medium.com/nouvelops/utiliser-la-license-windows-oem-de-son-pc-pour-une-vm-windows-sur-un-hote-virtualbox-linux-7ff6c51c1153](https://medium.com/nouvelops/utiliser-la-license-windows-oem-de-son-pc-pour-une-vm-windows-sur-un-hote-virtualbox-linux-7ff6c51c1153) 

Avant de booter sur l’ISO de Windows 10 il va falloir paramétrer la VM pour qu’elle présente la même table MSDM à l’OS invité.

Copie du contenu de la table MSDM:

	sudo cat /sys/firmware/acpi/tables/MSDM > ~/VirtualBox\ VMs/win10/msdm.bin

Ajout de la table MSDM à la configuration de la VM (la VM s’appelle win10 dans mon cas) :

	VBoxManage setextradata win10 "VBoxInternal/Devices/acpi/0/Config/CustomTable" ~/VirtualBox\ VMs/win10/msdm.bin

Vous pouvez maintenant démarrer la VM sur l’ISO de Microsoft Windows 10 et installer l’OS.

Aucune clé d’activation ne sera demandée, et a l’issue de l’installation Windows sera activé.