#!/bin/bash
 
# 04/01/2017
# christian.pottier@univ-angers.fr

# Flashplayer Projector (pour fichier animation swf)
# 15/05/2017 changement site adobe http://www.adobe.com/software/flash/about/ -> http://get.adobe.com/flashplayer/about/
# 13/02/2019 debian 10

TYPE_ARCH=$(dpkg --print-architecture)
if [ "$TYPE_ARCH" = "i386" ] ; then
	exit
fi

if ( sudo apt-cache policy curl | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y install curl
fi
# Version adobe
VERSION=$(curl -s http://get.adobe.com/flashplayer/about/ |  awk 'BEGIN{RS="<td rowspan=\""; FS="</td>"} /Linux/ {for(i=1;i<NF;i++) if($i~/Firefox - NPAPI/){i++;sub(/^[^0-9]*/,"",$i);print $i}}')
echo "Version flash Adobe      : $VERSION"

# Version actuelle
OLD_VERSION="0.0.0.0"

if [ -r /usr/bin/flashplayer ] ; then
	OLD_VERSION=$(strings "/usr/bin/flashplayer" 2>/dev/null | grep LNX | cut -d' ' -f2 | sed -e 's/,/./g')
fi
echo "Version Flash (Projector) installée  : $OLD_VERSION"

if dpkg --compare-versions "$VERSION" gt "$OLD_VERSION" ; then
	echo "Nouvelle version Flash (Projector) disponible ..."
else
	echo "Déjà la dernière version Flash (Projector)"
	exit
fi

NOMFLASH="flash_player_sa_linux.x86_64"

wget -N -P /tmp/ https://fpdownload.macromedia.com/pub/flashplayer/updaters/$(expr substr "$VERSION" 1 2)/${NOMFLASH}.tar.gz

sudo tar xf /tmp/$NOMFLASH.tar.gz -C /tmp/

sudo install /tmp/flashplayer /usr/bin/

exit