# Clonezilla Live

## Clonezilla Live EFI

- Télécharger le fichier clonezilla-live **zip**
	[https://clonezilla.org/downloads.php](https://clonezilla.org/downloads.php])
- Préparer la clé en GPT avec une partition **FAT** (CLONEZILLA)
- Décompresser le fichier **clonezilla-live-n.n.n-nn-amb64.zip** sur la partition FAT.

Exemple :

	unzip clonezilla-live-3.3.0-33-amd64.zip -d /media/$USER/CLONEZILLA/

## Préparation Clonezilla recovery

	debclean
	cd /opt/madeb
	sh prepclone.sh
	sudo poweroff
	
Faire la sauvegarde avec clonezilla sur un support externe **en mode expert pour la taille des fichiers à 4096**. (limite FAT32)


### Clonezilla : Option recovery-iso-zip (mode expert)

Pour choisir et adopter la taille du disque cible à la restauration:  

Périphérique à restaurer : mettre **ask_user**
Paramètres supplémentaires écran 1 : Mettre option **-icds**
Paramètres supplémentaires écran 2 : mettre **-k1**

Créer "**zip file**" (ou tar)  


### Installation sur la clé (GPT + FAT)

Formater la clé en FAT avec comme nom DFCLONE  
Monter la clé  

	unzip clonezilla-live-DF12-img.zip -d /media/$USER/DFCLONE/
	
ou
	tar xvf clonezilla-live-DF12-img.tar -C /media/$USER/DFCLONE/
	

### Faire la clé bootable (Inutile pour EFI)

	cd /media/$USER/DFCLONE/utils/linux/

	sudo bash makeboot.sh /dev/sdxn
	
Remplacer /dev/sdxn1 par le périphérique de la clé USB.


## Clonage de la clé

script : clone_DFCLONE.sh

Clé source : /media/bonjour/DFCLONE (/dev/sdb)

Clé de destinataion : /dev/sdc

	# Table des partitions
	sudo parted -s /dev/sdc mklabel msdos
	# Creation de la partition FAT
	sudo parted -s /dev/sdc mkpart primary fat32 0% 100%
	# formatage de la partition
	sudo mkfs.vfat -n DFCLONE /dev/sdc1
	# montage (/dev/sdc1 at /media/bonjour/DFCLONE1)
	udisksctl mount -b /dev/sdc1
	# synchronisation
	rsync -av --progress /media/bonjour/DFCLONE/ /media/bonjour/DFCLONE1/
	# faire la clé bootable
	sudo bash /media/bonjour/DFCLONE1/utils/linux/makeboot.sh /dev/sdc1
	

## Mise à jour de la clé

 voir script :
 
	 /opt/madeb/maj_DFCLONE.sh
