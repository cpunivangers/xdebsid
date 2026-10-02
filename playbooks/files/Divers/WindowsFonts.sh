#!/bin/sh
 
# 03/03/2023
# christian.pottier@univ-angers.fr
#  
# Paquet de base :
# sudo apt install -y ttf-mscorefonts-installer
#

if [ -d "/usr/share/fonts/truetype/WindowsFonts" ]; then
	exit 0
fi

rm -rf WindowsFonts/
mkdir -p WindowsFonts

# Polices vista
wget -O /tmp/PowerPointViewer.exe https://web.archive.org/web/20171225132744/http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
cabextract -F ppviewer.cab -d /tmp/ /tmp/PowerPointViewer.exe
rm -rf /tmp/fonts_vista
mkdir -p /tmp/fonts_vista
cabextract -F '*.TT?' -d /tmp/fonts_vista /tmp/ppviewer.cab
# renommer les polices en minuscules
for itt in /tmp/fonts_vista/*
do
	mv "$itt" `echo $itt | tr [:upper:] [:lower:]`

done
cp -r /tmp/fonts_vista/* WindowsFonts/

# Windows fonts à partir d'une image ISO de Windows
PATH_ISO="$HOME/Téléchangements/Win10_22H2_French_x64.iso"
if [ ! -e $PATH_ISO ]; then
	URLWIN="https://windowstan.com/download/windows-10-22h2-x86"
	HREF=$(curl -sl $URLWIN | hxnormalize | grep -i "$URLWIN/?" | sed -n 's,.* href="\(.*\)".*$,\1,p' )
	wget -O /tmp/win.iso "$HREF"
	PATH_ISO="/tmp/win.iso"
fi
if [ -e $PATH_ISO ]; then
	sudo mkdir -p /tmp/iso
	sudo mount -o loop $PATH_ISO /tmp/iso
	rm -rf WindowsFonts/
	7z e /tmp/iso/sources/install.wim 1/Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf} -aoa -o./WindowsFonts
	sudo umount /tmp/iso
fi

echo  "Nettoyage des polices déjà existantes avec msttcorefonts"
for itt in /usr/share/fonts/truetype/msttcorefonts/*
do
	if [ -e "WindowsFonts/${itt##*/}" ]; then
		echo "${itt##*/}"
		rm -f "WindowsFonts/${itt##*/}"
	fi
   
done

# Fusion des polices wingdng2
cp -r fonts_wingdng/* WindowsFonts/

sudo mv WindowsFonts /usr/share/fonts/truetype/

# mise à jour du cache des polices
fc-cache -fv

