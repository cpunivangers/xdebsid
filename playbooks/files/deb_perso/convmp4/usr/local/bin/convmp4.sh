#!/bin/bash
# Script pour convertir une video en mp4

#
# Christian.pottier@univ-angers.fr
# Version : 0.1
# Licence : GNU/GPL
# 20/09/2016

LIST_FICHIERS="$*"
if [ -z $LIST_FICHIERS ]; then
	LIST_FICHIERS=`zenity --file-selection --title="Sélectionnez un fichier"`
fi

#Pour chaque fichier sélectionné (appelé alors 'arg'), on converti
for arg in "$LIST_FICHIERS"
do
	#Le chemin du fichier devient la variable 'CHEMIN'
	CHEMIN=$(dirname "$arg");
	#Le nom du fichier (sans extension) devient la variable 'NOM_FICHIER'
	FICHIER=$(basename "$arg"); #On récupère d'abord le nom du fichier avec son extension
	NOM_FICHIER=${FICHIER%.*}; #On lui enlève ensuite l'extension
	EXT_FICHIER=${FICHIER##*.}; #On récupère l'extension
	case "$EXT_FICHIER" in
		mpg | MPG | mpeg | MPEG | mov | MOV ) ;;
		* ) continue ;;
	esac


	#On exécute la commande de conversion avec les paramètres qui vont bien :
	# - le fichier de sortie qui sera dans le dossier source
	ffmpeg -deinterlace -i "$arg" "$CHEMIN/$NOM_FICHIER.mp4"
done

zenity --info --text="Conversion mp4 effectuée ..."

exit
