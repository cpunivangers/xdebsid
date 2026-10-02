#!/bin/bash
# Script pour optimaiser les fichiers epub

#
# Christian.pottier@univ-angers.fr
# Version : 0.1
# Licence : GNU/GPL
# 04/02/2025

function optimepub () {
	# Vérifiez si le fichier est passé en argument
	if [ -z "$1" ]; then
		echo "Usage: $0 fichier.epub"
		return 1
	fi
	# Nom du fichier EPUB
	EPUB_FILE="$1"
	WORK_DIR="epub_contents"
	# Décompressez le fichier EPUB
	mkdir -p "$WORK_DIR"
	unzip -qq "$EPUB_FILE" -d "$WORK_DIR"

	# Liste des images utilisées
	USED_IMAGES=$(mktemp)
	PATH_USED_IMAGES=$(mktemp)

	# Parcourez les fichiers xhtml et extrayez les images référencées
	find "$WORK_DIR" -type f -name "*.xhtml" -o -name "*.html" | while read -r html_file; do
		grep -oP '(?<=img src=")[^"]*' "$html_file" >> "$USED_IMAGES"
		grep -oP 'src="([^"]+\.(jpg|jpeg|png|gif))"' "$html_file" | sed 's/src="//;s/"$//' >> "$USED_IMAGES"
	done

	# Supprimez les doublons des chemins dans la liste
	sort -u -o "$USED_IMAGES" "$USED_IMAGES"

	# Chemins complets des images dans le repertoire
	#sed -i "s|^|$WORK_DIR/|" "$USED_IMAGES"
	while IFS= read -r file_used; do
		find "$WORK_DIR" -iwholename "*/$file_used" >> "$PATH_USED_IMAGES"
	done < "$USED_IMAGES"

	# Supprimez les images qui ne sont pas référencées
	find "$WORK_DIR" -type f -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" | while read -r image_file; do
		if ! grep -qx "$image_file" "$PATH_USED_IMAGES"; then
			echo "Suppression de l'image non utilisée: $image_file"
			rm "$image_file"
		else
			ext_img=${image_file##*.}; #On récupère l'extension
			case "$ext_img" in
				jpg | JPG )
					jpegoptim --max=30 $image_file
				;;
				png | PNG )
					optipng -o5 $image_file
				;;
				* ) continue ;;
			esac		
		fi
	done

	# Optionnel: Nettoyez après le traitement
	rm "$USED_IMAGES"
	rm "$PATH_USED_IMAGES"

	# Zippez de nouveau les fichiers pour créer un nouvel EPUB
	NEW_EPUB="${EPUB_FILE%.epub}_cleaned.epub"
	cd "$WORK_DIR" || exit
	zip -Xqr "../$NEW_EPUB" *
	cd .. || exit

	# Supprimer le répertoire temporaire
	rm -rf "$WORK_DIR"

	echo "Nouveau fichier EPUB sans les images inutilisées: $NEW_EPUB"
}


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
		epub | EPUB ) ;;
		* ) continue ;;
	esac

	optimepub "$arg"
done

zenity --info --text="Optimisation epub effectuée ..."

exit
