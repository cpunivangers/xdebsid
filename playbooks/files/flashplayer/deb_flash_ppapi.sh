#!/bin/sh
 
# 01/2017
# christian.pottier@univ-angers.fr

# inspiré par https://forums.bunsenlabs.org/viewtopic.php?id=1873&p=3

# Flashplayer PPAPI Adobe pour Chromium
# 15/05/2017 changement site adobe http://www.adobe.com/software/flash/about/ -> http://get.adobe.com/flashplayer/about/
# 13/02/2019 debian 10

# On remplace :
if [ ! -d /usr/lib/pepperflashplugin-nonfree ] ; then
	sudo mkdir -p /usr/lib/pepperflashplugin-nonfree
fi
CONFIG_CHROMIUM="/etc/chromium.d/pepperflashplugin-nonfree"
if ! (grep -q 'strings $flashso' $CONFIG_CHROMIUM) ; then
	# correction config chromium
	sudo rm $CONFIG_CHROMIUM
fi
if [ ! -r $CONFIG_CHROMIUM ] ; then
	echo 'flashso=/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so' | sudo tee $CONFIG_CHROMIUM
	echo "flashversion=\`strings "'$flashso 2> /dev/null '"|"" grep LNX ""|"" cut -d ' ' -f 2 ""|"" sed -e 's/,/./g'\`" | sudo tee -a $CONFIG_CHROMIUM
	echo 'CHROMIUM_FLAGS="$CHROMIUM_FLAGS --ppapi-flash-path=$flashso --ppapi-flash-version=$flashversion"' | sudo tee -a $CONFIG_CHROMIUM
fi


# Version adobe
VERSION=$(curl -s http://get.adobe.com/flashplayer/about/ |  awk 'BEGIN{RS="<td rowspan=\""; FS="</td>"} /Linux/ {for(i=1;i<NF;i++) if($i~/Chromium-based browsers - PPAPI/){i++;sub(/^[^0-9]*/,"",$i);print $i}}')
echo "Version flash PPAPI Adobe     : $VERSION"

# Version actuelle
OLD_VERSION="0.0.0.0"
if [ -r /usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so ] ; then
	if [ -r /usr/lib/pepperflashplugin-nonfree/readme.txt ] ; then
		OLD_VERSION=$(cat /usr/lib/pepperflashplugin-nonfree/readme.txt | sed -n '3p')
	else
		OLD_VERSION=$(strings "/usr/lib/pepperflashplugin-nonfree/libpepflashplayer.so" 2>/dev/null | grep LNX | cut -d' ' -f2 | sed -e 's/,/./g')
	fi
fi
echo "Version flash PPAPI installée : $OLD_VERSION"

if dpkg --compare-versions "$VERSION" gt "$OLD_VERSION" ; then
	echo "Nouvelle version flash PPAPI (Chromium) disponible ..."
else
	echo "Déjà la dernière version flash PPAPI (Chromium)"
	exit
fi

TYPE_ARCH=$(dpkg --print-architecture)
if [ "$TYPE_ARCH" = "i386" ] ; then
	NOMFLASH="flash_player_ppapi_linux.i386"
else
	NOMFLASH="flash_player_ppapi_linux.x86_64"
fi
wget -N -P /tmp/ https://fpdownload.adobe.com/pub/flashplayer/pdc/${VERSION}/${NOMFLASH}.tar.gz
sudo rm -rf /usr/lib/pepperflashplugin-nonfree/*
sudo tar xf /tmp/$NOMFLASH.tar.gz -C /usr/lib/pepperflashplugin-nonfree/

exit

