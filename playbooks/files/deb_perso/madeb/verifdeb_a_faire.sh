#!/bin/sh
 
# 04/2021
# christian.pottier@univ-angers.fr
#  
# vérif deb à faire ?
DIRSVG=$(basename $(pwd))

cd ..

find $DIRSVG -type f -newer $DIRSVG.deb -and -not -path \*/.\* -printf "%h/%f : Date modif =  %Td %Tb %TY\n" | more
