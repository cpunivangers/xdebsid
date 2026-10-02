## récuperer licence Windows du Bios UEFI
sudo strings /sys/firmware/acpi/tables/MSDM

ou
sudo hexdump -s 56 -e '"MSDM key: " /29 "%s\n"' /sys/firmware/acpi/tables/MSDM

## Nom de la session
SESSION=${HOME:6}

## copier clé usb bootable
dd if=image.iso of=/dev/sdc bs=4M status=progress && sync
## ou
(pv -n image.iso | dd of=/dev/sdc bs=4M && sync) 2>&1 | dialog --gauge "la commande dd est en cours d'exécution, merci de patienter..." 10 70 0

## Espace libre

	df --sync -h

# Mise à jour de sécurité automatique
sudo apt install unattended-upgrades apt-listchanges
sudo dpkg-reconfigure -plow unattended-upgrades

# date heure sur les commandes
echo 'export HISTTIMEFORMAT="%y%m%d %T "' | tee -a ~/.bashrc

# cloner machine avec dd et ssh (http://www.linuxtricks.fr/news/10-logiciels-libres/228-cloner-une-machine-avec-dd-sur-ssh-dd-over-ssh/)
# boot live linux sur les 2 machines
# clonnage (pv pour visualiser la progression
dd if=/dev/sda | pv | ssh 10.21.21.231 "dd of=/dev/sda"
# a tester
dd if=/dev/sda | ssh 10.21.21.231 "dd of=/dev/sda status=progress"
# avec compression
dd if=/dev/sda | pv | gzip | ssh 10.21.21.231  'gzip -d | dd of=/dev/sda'

# rechercher les gros fichiers

	sudo du -xhd1

### Trié

	sudo du -xhmd1 | sort -nr | head


Seulement le local :

	du -lh
### Espace utilisé (-x uniquement le local)
	ncdu -x /

#!/bin/sh
# Enregistre le son
AUDIODEV=hw:0,0 rec -r 44100 -p | sox -p "Capture - Le $(date '+%d-%m-%Y') à $(date +"%T").ogg" silence -l 1 00:00:00.5 -45d -1 00:00:00.5 -45d

# Voir les connections en-cours
$ netstat -puant
$ netstat -lapute

# Noms de fichiers
ls -l | awk '{ for (i=9 ; i <= NF ; i++) { printf "%s ",$i } printf "\n"}'

Puis on va utiliser l'option "--rsync-path" pour préciser à rsync de démarrer avec l'option sudo :
rsync -av --progress --stats --human-readable --rsync-path="sudo rsync" -e "ssh -p xxxx" useronremoteserver@remoteserver:/data/to/sync /archive/data/

## tester scripts shell
### Vérification syntaxe sans execution
	sh -n nom_du_script
### debug script
	sh -x nom_du_script

## Erreurs au boot
	sudo dmesg -k -l err,warn
## cpu 32 ou 64
	lscpu | grep -i "mode(s)"

## type de disque
	cat /sys/block/sda/queue/rotational
** 0 = SSD**
** 1 = SATA ou SCSI**

