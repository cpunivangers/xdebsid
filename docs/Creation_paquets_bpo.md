# Fabrication de paquets rétroportés  (backports)

Référence : https://wiki.debian.org/fr/SimpleBackportCreation

Exemple avec le logiciel **auto-multiple-choice** dans SID

## Outils :

	sudo apt-get install packaging-dev debian-keyring devscripts equivs

## Ajout des sources unstable (sid) ou testing dans les sources listes :

	echo "deb-src  http://deb.debian.org/debian/ unstable main" | sudo tee  /etc/apt/sources.list.d/src-unstalble.list
	echo "deb-src  http://deb.debian.org/debian/ testing main" | sudo tee  /etc/apt/sources.list.d/src-testing.list
	sudo apt update

## Voir les versions de paquet dispo :

	rmadison auto-multiple-choice-common

## Récupération du source :

	apt source auto-multiple-choice-common/unstable

## Compilation du paquets (et dépendances):

	cd auto-multiple-choice-1.5.2/

### Récupération des dépendances pour compiler :

	sudo mk-build-deps --install --remove

### Ajout  numéro de révision de backport :

	dch --bpo

### Test compilation :

	fakeroot debian/rules binary
	
### Compilation sans signature :

	dpkg-buildpackage -b -us -uc

## Installation des paquets compilés

	cd ..
	sudo apt install ./auto-multiple-choice-common_1.5.2-5~bpo11+1_all.deb
	sudo apt install ./auto-multiple-choice_1.5.2-5~bpo11+1_amd64.deb 