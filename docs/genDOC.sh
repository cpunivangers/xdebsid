#!/bin/bash

# 10/2023
# christian.pottier@univ-angers.fr

# Dépendances :
#	sudo apt install pandoc wkhtmltopdf
STYLE="styleDOC"

DIR_CSS=$(pwd)/css
DIR_DOC=$(dirname $1)
NOM_DOC=$(basename $1 .md)

cd $DIR_DOC

AAMMJJ=$(date +%d/%m/%y" "%H:%M)
sed -i -e "s;^date: .*$;date: $AAMMJJ  ;" $NOM_DOC.md
echo "$NOM_DOC.pdf ..."
OPTION=""
if $(grep -q "number-sections: true" $NOM_DOC.md) ; then
	OPTION=" -N"
fi
pandoc --self-contained --pdf-engine=wkhtmltopdf --pdf-engine-opt=--enable-local-file-access -t html5 $OPTION --css $DIR_CSS/$STYLE.css -o $NOM_DOC.pdf $NOM_DOC.md
# ligne de commande tronquée avec weasyprint : revoir la feuille de style pour weasyprint !
#~ pandoc --self-contained --pdf-engine=weasyprint -t html5 $OPTION --css $DIR_CSS/$STYLE.css -o $NOM_DOC.pdf $NOM_DOC.md
