#!/bin/sh
 
# 02/2019
# christian.pottier@univ-angers.fr
# 
# Mime type defaut application

if ( sudo grep -q "Default" /etc/skel/.config/mimeapps.list ) ; then
	sudo rm /etc/skel/.config/mimeapps.list
fi
LMIMEAPPS="video/mp4=mpv.desktop text/plain=leafpad.desktop application/pdf=evince.desktop image/jpeg=gthumb.desktop image/png=gthumb.desktop"
LMIMEAPPS="$LMIMEAPPS application/x-ms-dos-executable=wine.desktop"
LMIMEAPPS="$LMIMEAPPS application/vnd.adobe.flash.movie=flashplayer.desktop application/x-shockwave-flash=flashplayer.desktop"
for MIMEAPPS in $LMIMEAPPS ; do
	if ( grep -q "$MIMEAPPS" /usr/share/applications/mimeapps.list ) ; then
		continue
	fi
	VAPPS=$(echo $MIMEAPPS | cut -d= -f2)
	if [ -f /usr/share/applications/$VAPPS ] ; then
		VMIME=$(echo $MIMEAPPS | cut -d= -f1 | sed 's/\//\\\//g')
		sudo sed -i -e "/$VMIME/d; /\[Default/a $MIMEAPPS" /usr/share/applications/mimeapps.list
		sudo sed -i -e "/$VMIME/d; /\[Default/a $MIMEAPPS" /usr/share/applications/defaults.list
		echo "Mise à jou mimeapps : $MIMEAPPS" | sudo tee -a $FICHLOG			
	fi
done