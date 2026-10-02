#!/bin/sh
 
# 10/2017
# christian.pottier@univ-angers.fr
#
# Répertoire de Travail
cd /tmp/
# Télécharger Visionneuse PowerPoint 2010
# 16/10/2018 retiré en avril 2018#wget https://download.microsoft.com/download/6/B/4/6B4CA627-C0CD-4B27-BE31-0B87AE10F46B/PowerPointViewer.exe
# extraire de l'exécutable
#cabextract -F ppviewer.cab PowerPointViewer.exe
# Dossier des fonts
#mkdir /tmp/fonts_vista
#cabextract -F '*.TT?' -d /tmp/fonts_vista ppviewer.cab
# renommer les polices en minuscules
#cd /tmp/fonts_vista
#for i in *; do mv "$i" `echo $i | tr [:upper:] [:lower:]`;done
# 16/10/2018
wget -O /tmp/fonts_vista.tar.gz --user-agent=Firefox --no-check-certificate "https://uabox.univ-angers.fr/public.php?service=files&t=LdTLAbfmO9bIlIq&download"
tar zxvf fonts_vista.tar.gz

# Mettre les polices dans le système
sudo mkdir -p /usr/share/fonts/truetype/vista
sudo cp -f /tmp/fonts_vista/*.ttf /usr/share/fonts/truetype/vista

# mise à jour du cache des polices
fc-cache -fv
