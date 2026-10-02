#!/bin/sh
 
# 06/2023
# christian.pottier@univ-angers.fr
#  
# vérif svgdir.sh à faire ?

if [ -z $1 ]; then
  DIRSVG=$(basename $(pwd))
  cd ..
  echo Répertoire à vérifier : $DIRSVG
else
	DIRSVG=$1
fi
if [ ! -d $DIRSVG ]; then
	echo "Répertoire $DIRSVG inexistant ..."
	exit 1
fi
find $DIRSVG -type f -newer $DIRSVG.tar.gz -and -not -path \*/.\* -printf "%h/%f : Date modif =  %Td %Tb %TY\n" | more
