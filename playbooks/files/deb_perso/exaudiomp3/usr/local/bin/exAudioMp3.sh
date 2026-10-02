#!/bin/bash
# Script pour extraire la piste audio et la mettre en mp3
#
# nécessite ffmpeg et libmp3lame
#
# Auteur : Christian Pottier christian.pottier@univ-angers.fr
# Version : 0.1
#
# Licence : GNU/GPL

#Pour chaque fichier sélectionné (appelé alors 'arg'), on applique la compression
for arg in "$*"
do
	#Le chemin du fichier devient la variable 'CHEMIN'
	CHEMIN=$(dirname "$arg");
	#Le nom du fichier (sans extension) devient la variable 'NOM_FICHIER'
	FICHIER=$(basename "$arg"); #On récupère d'abord le nom du fichier avec son extension
	NOM_FICHIER=${FICHIER%.*}; #On lui enlève ensuite l'extension

	#On exécute la commande de ffmpeg :
	ffmpeg -i "$arg" -vn -acodec libmp3lame "$CHEMIN/$NOM_FICHIER.mp3"
done

exit
