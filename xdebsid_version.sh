#!/bin/bash
 
# 12/03/2026
# christian.pottier@univ-angers.fr
#

## Version actuelle
OLD_VERSION=$(head -1 /opt/ansible/xdebsid/Version.txt 2>/dev/null)

## Version nouvelle : la dernière
### Dépot Github
repoGit="cpunivangers/xdebsid"

## Dépendance
if ( apt-cache policy dos2unix | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y install dos2unix
fi
latest="https://github.com/$repoGit/releases/latest"
HREF=$(curl -sI "$latest" | dos2unix | grep -i 'location:' | cut -d" " -f2)
VERSION=$(basename $(curl -sI "$latest" | dos2unix | grep -i 'location:' | cut -d" " -f2))

echo "Version disponible : $VERSION"
echo "Version actuelle   : $OLD_VERSION"
if [ -z "$VERSION" ] ; then
	echo -e $rouge ERREUR Version disponible
	read tempo
	exit 1
fi
if dpkg --compare-versions "$VERSION" gt "$OLD_VERSION" ; then
	echo "Nouvelle version disponible ..."
else
	echo -n "Déjà la dernière version"
	read tempo
	exit
fi

read -r -p "Souhaitez-vous mettre à jour ? (O/..) : " resp
if [[ "$resp" != [OYoy] ]]; then
	exit
fi

curl -sL https://raw.githubusercontent.com/$repoGit/main/update_xdebsid.sh | bash
