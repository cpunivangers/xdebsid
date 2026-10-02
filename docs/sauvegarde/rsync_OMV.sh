#!/bin/bash
# 
# 31/08/2018
# Christian pottier
# Sauvegarde omv
# dependance : rsync, wakeonlan

# Sur la machine de sauvegarde
# 
# Créer un compte system svgomv, il sera invisible pour les autres utilisateurs.
# mettre dans le groupe sudo, mettre un mot de passe et le shell pour ssh
#	sudo adduser --system svgomv
#	sudo adduser svgomv sudo
#	sudo passwd svgomv
#	sudo chsh -s /bin/bash svgomv
#
# Sur la machine OMV, copier id ssh pour la conexion sans mot de passe
#	ssh-copy-id svgomv@192.168.0.202

# test bash
if [ -z $BASH ]; then
	echo "Lancer avec bash !"
	exit 1
fi

LOGFILE="/var/log/rsync_OMV.log"
exec > >(tee -a "$LOGFILE") 2>&1

## Test support
IPSVG="svgomv@192.168.0.202"
MACSVG="f8:b1:56:ad:51:12"

echo Sauvegarde sur PC : $IPSVG $MACSVG
date
# Test PC accessible
ssh $IPSVG "echo Bonjour"
if [ $? -ne  0 ] ; then
	echo Allume le pc
	wakeonlan $MACSVG
	echo attente 90 s
	sleep 90
	ssh $IPSVG "echo Bonjour"
	if [ $? -ne  0 ] ; then
		echo " PC sauvegarde non accessible ! "
		exit 1
	fi
	ALLUME=true
fi

SOURCE='/sharedfolders/'
DESTINATION=$IPSVG':/mnt/SVGOMV/sharedfolders'
DIRBACKUP=$(date +%Y-%m-%d)

# Exclusions
EXCLUDE_TEMP=' --exclude=TEMP/ --exclude=temp/'
EXCLUDE_TRASH=' --exclude=.Trash/ --exclude=.Trash-*/'
EXCLUDE_LOCK=' --exclude=*~.lock*'
# Historique
BACKUP="--backup --backup-dir=$DIRBACKUP"
# options pour rsync
OPTIONS="$EXCLUDE_TEMP $EXCLUDE_TRASH $EXCLUDE_LOCK --delete $BACKUP -av"

LibS="Sauvegarde rsync de $SOURCE vers $DESTINATION ..."
echo "Sauvegarde $LibS ..."
date
echo "rsync $OPTIONS $SOURCE $DESTINATION"
rsync $OPTIONS "$SOURCE" "$DESTINATION"
if [ $? -ne  0 ]
then
	echo " Erreur : sauvegarde $LibS "
fi
echo "Fin sauvegarde $Libs ..."
date

echo "Espace sur sauvegarde :"
ssh $IPSVG "df -h"
date

# copie du fichier log
scp $LOGFILE $DESTINATION/$DIRBACKUP.log

# Test utilisateurs connectés
USERSCONNECT=$(ssh $IPSVG "users")
if [ "$USERSCONNECT" = "" ]
then
	echo arrêt du pc de sauvegarde
	ssh $IPSVG "systemctl poweroff"
else
	echo "$USERSCONNECT connecté !"
fi
date

exit
