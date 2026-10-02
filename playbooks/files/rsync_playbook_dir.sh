#!/bin/sh
 
# 17/02/2021
# christian.pottier@univ-angers.fr
#  
# maj /opt/ansible/xxx d'un poste avec rsync
DIRSVG=$(basename $(pwd))

if [ -z $1 ]; then
	echo -n Adresse IP du poste :
	read IPDEST
else
	IPDEST=$1
fi
if [ -z $IPDEST ]; then
	exit 0
fi
if ( echo "$IPDEST" | grep -q @ ) ; then
	UTIL=${IPDEST%%@*}
	IPDEST=${IPDEST##*@}
else
	if [ -z $2 ]; then
		UTIL=administrateur
	else
		UTIL=$2
	fi
fi

#rsync -avx --progress --delete ../$DIRSVG $UTIL@$IPDEST:TEMP/

#ssh -t $UTIL@$IPDEST "sudo rsync -avx --progress --delete TEMP/$DIRSVG /opt/ansible/"

rsync --rsync-path "sudo rsync" -avx --progress --delete --chown="root:" "$(pwd)" $UTIL@$IPDEST:/opt/ansible/

exit

