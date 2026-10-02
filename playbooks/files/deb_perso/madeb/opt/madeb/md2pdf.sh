#!/bin/bash

# Vérifie si pandoc est installé
if ! command -v pandoc &> /dev/null
then
    echo "Pandoc n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi
#~ # Vérifie si wkhtmltopdf est installé
if ! command -v wkhtmltopdf &> /dev/null
then
    echo "wkhtmltopdf n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Vérifie si un argument est fourni
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 fichier.md"
    exit 1
fi

# Le fichier Markdown en entrée
input_file="$1"

# Vérifie si le fichier existe
if [ ! -f "$input_file" ]; then
    echo "Le fichier $input_file n'existe pas."
    exit 1
fi

# Crée le nom de fichier PDF de sortie
output_file="${input_file%.md}.pdf"

# Convertit le fichier Markdown en PDF
pandoc --self-contained --pdf-engine=wkhtmltopdf --pdf-engine-opt=--enable-local-file-access -t html5 "$input_file" -o "$output_file"
#~ pandoc --self-contained --pdf-engine=weasyprint -t html5 "$input_file" -o "$output_file"


echo "La conversion est terminée. Le fichier PDF est : $output_file"
