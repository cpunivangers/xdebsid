#!/bin/bash
 
# 01/2017
# christian.pottier@univ-angers.fr

# inspiré par https://forums.bunsenlabs.org/viewtopic.php?id=1873&p=3

# Flashplayer NPAPI pour firefox
# 15/05/2017 changement site adobe http://www.adobe.com/software/flash/about/ -> http://get.adobe.com/flashplayer/about/
# 14/06/2017 flashplugin-nonfree ne marche plus -> supprime
# 13/02/2019 debian 10

# remplacement de flashplugin-nonfree
#if ! ( sudo apt-cache policy flashplugin-nonfree | grep Installé | grep -q aucun ) ; then
#	sudo apt-get -y purge flashplugin-nonfree
#fi
if [ ! -d /usr/lib/flashplugin-nonfree ] ; then
	sudo mkdir -p /usr/lib/flashplugin-nonfree
fi

if ( sudo apt-cache policy curl | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y install curl
fi
# Version adobe
VERSION=$(curl -s http://get.adobe.com/flashplayer/about/ |  awk 'BEGIN{RS="<td rowspan=\""; FS="</td>"} /Linux/ {for(i=1;i<NF;i++) if($i~/Firefox - NPAPI/){i++;sub(/^[^0-9]*/,"",$i);print $i}}')
echo "Version flash NPAPI Adobe      : $VERSION"

# Version actuelle
OLD_VERSION="0.0.0.0"
if [ -r /usr/lib/flashplugin-nonfree/libflashplayer.so ] ; then
	if [ -r /usr/lib/flashplugin-nonfree/readme.txt ] ; then
		OLD_VERSION=$(cat /usr/lib/flashplugin-nonfree/readme.txt | sed -n '3p' | cut -d" " -f2)
	else
#		OLD_VERSION=$(strings "/usr/lib/flashplugin-nonfree/libflashplayer.so" 2>/dev/null | sed -n '/LNX/ {s/^LNX //;s/,/./gp}')
		OLD_VERSION=$(strings "/usr/lib/flashplugin-nonfree/libflashplayer.so" 2>/dev/null | grep LNX | cut -d' ' -f2 | sed -e 's/,/./g')
	fi
fi
echo "Version flash NPAPI installée  : $OLD_VERSION"

if dpkg --compare-versions "$VERSION" gt "$OLD_VERSION" ; then
	echo "Nouvelle version flash NPAPI (Firefox) disponible ..."
else
	echo "Déjà la dernière version flash NPAPI (Firefox)"
	exit
fi
TYPE_ARCH=$(dpkg --print-architecture)
if [ "$TYPE_ARCH" = "i386" ] ; then
	NOMFLASH="flash_player_npapi_linux.i386"
else
	NOMFLASH="flash_player_npapi_linux.x86_64"
fi

wget -N -P /tmp/ https://fpdownload.adobe.com/pub/flashplayer/pdc/${VERSION}/${NOMFLASH}.tar.gz

sudo tar xf /tmp/$NOMFLASH.tar.gz -C /usr/lib/flashplugin-nonfree/


# Lien vers flashplugin-nonfree
sudo update-alternatives --quiet --install /usr/lib/mozilla/plugins/flash-mozilla.so flash-mozilla.so /usr/lib/flashplugin-nonfree/libflashplayer.so 50

exit

