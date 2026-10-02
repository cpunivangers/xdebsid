#!/bin/bash
 
# 28/01/2025
# christian.pottier@univ-angers.fr
#

### Dépot Github
repoGit="rustdesk/rustdesk"

OLD_VERSION="0.0"
if $( dpkg -s rustdesk 2> /dev/null | grep -q 'Status: install') ; then
  OLD_VERSION=$(dpkg -s rustdesk | grep "^Version" | cut -d" " -f2 | cut -d":" -f2)
fi

## Dépendance
if ( apt-cache policy dos2unix | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y install dos2unix
fi
latest="https://github.com/$repoGit/releases/latest"
HREF=$(curl -sI "$latest" | dos2unix | grep -i 'location:' | cut -d" " -f2)
VERSION=$(basename $(curl -sI "$latest" | dos2unix | grep -i 'location:' | cut -d" " -f2))
HREF="https://github.com/$repoGit/releases/download/$VERSION/rustdesk-$VERSION-x86_64.deb"

echo "Version disponible : $VERSION"
echo "Version actuelle   : $OLD_VERSION"
if [ -z "$VERSION" ] ; then
	echo -e $rouge ERREUR Version disponible
	exit
fi

if dpkg --compare-versions "$VERSION" gt "$OLD_VERSION" ; then
	echo "Nouvelle version disponible ..."
else
	echo "Déjà la dernière version"
	exit
fi

sudo rm -f /tmp/rustdesk.deb

# https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-x86_64.deb
wget -O /tmp/rustdesk.deb $HREF

sudo apt install -y /tmp/rustdesk.deb
