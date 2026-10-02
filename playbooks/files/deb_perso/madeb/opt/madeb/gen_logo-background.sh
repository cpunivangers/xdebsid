#!/bin/bash -e
 
# 10/2017
# christian.pottier@univ-angers.fr
#  
# Fond d'écran avec logo dans ~/Images/logo.png
#

cp -f ~/Images/logo.png /tmp/logo.png

## Composition de l'écran de login
DIR_BACKGROUND=/usr/share/desktop-base/active-theme/login
FICH_BACKGROUND=background.svg
cp -f $DIR_BACKGROUND/$FICH_BACKGROUND /tmp/$FICH_BACKGROUND
sed -i -e "/<image\ xlink/d" /tmp/$FICH_BACKGROUND
sed -i -e 's/<\/svg>/\n<image\ xlink:href="logo.png"\ x="800"\ y="200"\ height="350"\ width="350"\ \/>\n<\/svg>/' /tmp/$FICH_BACKGROUND
sed -i -e '/^$/d' /tmp/$FICH_BACKGROUND

#sudo cp -f ~/Images/logo.png $DIR_BACKGROUND
#sudo cp -f /tmp/$FICH_BACKGROUND $DIR_BACKGROUND

## Composition du fond d'écran du bureau
DIR_BACKGROUND=/usr/share/desktop-base/active-theme/wallpaper/contents/images
FICH_BACKGROUND=1920x1200.svg
cp -f $DIR_BACKGROUND/$FICH_BACKGROUND /tmp/$FICH_BACKGROUND
sed -i -e "/<image\ xlink/d" /tmp/$FICH_BACKGROUND
sed -i -e 's/<\/svg>/\n<image\ xlink:href="logo.png"\ x="1000"\ y="200"\ height="400"\ width="400"\ \/>\n<\/svg>/' /tmp/$FICH_BACKGROUND
sed -i -e '/^$/d' /tmp/$FICH_BACKGROUND

#sudo cp -f ~/Images/logo.png $DIR_BACKGROUND
#sudo cp -f /tmp/$FICH_BACKGROUND $DIR_BACKGROUND
