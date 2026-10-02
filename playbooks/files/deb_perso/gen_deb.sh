#!/bin/sh
 
# Fabrication paquet deb compressPDF, exAudioMp3 ...
# 09/2015
# christian.pottier@univ-angers.fr
#
# date -R pour le format date international pour le changelog

#08/11/2016 ajout pour script postinst
#27/04/2020 ajout maj version task yml

if [ -z $1 ]; then
	exit
fi

REPDEB=$(basename $1)

if [ ! -d "$REPDEB" ]; then
	exit
fi

AAMMJJ=$(date +%y%m%d.%H%M)
sudo sed -i -e "s/^Version: .*$/Version: $AAMMJJ/" $REPDEB/DEBIAN/control 

TAILLE=$(du -s $REPDEB/ | cut -f1)
sudo sed -i -e "s/^Installed-Size:.*$/Installed-Size: $TAILLE/" $REPDEB/DEBIAN/control

#~ sudo chmod 755 $REPDEB/DEBIAN/post*
#~ sudo chmod 755 $REPDEB/DEBIAN/pre*

#~ sudo dpkg-deb --build $REPDEB
fakeroot -- dpkg-deb --build $REPDEB
if [  -f ../../tasks/perso_$REPDEB.yml ]; then
	echo "version perso_$REPDEB.yml"
	sed -i -e "s/      vers: .*$/      vers: $AAMMJJ/" ../../tasks/perso_$REPDEB.yml
fi
exit
