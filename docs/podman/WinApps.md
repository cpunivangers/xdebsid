# podman WinApps 

## Installation de windows 11 et M365 sur un poste Linux (Debian 12) avec podman (<=>docker) et WinApps.

Références :

https://gist.github.com/eylenburg/38e5da371b7fedc0662198efc66be57b#option-1-running-any-office-version-including-365-with-winapps

https://github.com/winapps-org/winapps/tree/main

https://www.reddit.com/r/kde/comments/1hdprr2/msoffice_on_linux_using_winapps/?tl=fr


- J'ai suivi les instructions du premier lien et tenu compte des remarques du dernier lien.
	- Il faut patienter lors du téléchargement de l'iso "tiny11" (Version réduite de Windows).
- J'ai regardé aussi les videos https://xavki.blog/podman-tutoriels-fr/ pour comprendre le fonctionnement.
- J'ai installé M365 dans le conteneur WinApps qui a été créé par podman-compose.
- J'ai lancé l'étape ./setup.sh pour intégrer les applications Windows dans le menu Linux.

Cela marche très bien et semble bien réactif.

## Installation

	sudo apt install -y curl dialog freerdp3-x11 git iproute2 libnotify-bin netcat-openbsd
	sudo apt install -y podman
	sudo apt install -y -t bookworm-backports podman-compose
	mkdir ~/.local/bin
	cd ~/.local/bin
	git clone https://github.com/winapps-org/winapps
	cd winapps
	podman-compose --file ./compose.yaml up
