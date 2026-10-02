# Gestion des paquets apt et dpkg

## apt
### Liste des paquets installés localement (sans dépots)

	apt list --installed | grep /now
	
### Liste des paquets installés et qui sont disponibles dans le dépot backports 

	dpkg -l | grep ^ii| awk {'print $2'} | xargs apt-cache policy | grep -B 5 backports | grep ^[a-z] | cut -d: -f1

### Liste des paquets installés du dépot backports

	apt list --installed | grep backports
	

### Liste des paquets d'un dépot

	grep Package /var/lib/apt/lists/packages.microsoft.com*_Packages | awk '{print $2;}


### liste des paquets ayant des résidus de configuration :

	sudo apt list ~c

ou

	dpkg -l | grep -v '^ii'

pour les supprimer :

	sudo apt purge ~c

## dpkg

### Y-a-t-il des paquets incohérents :

	dpkg --audit

### À quel paquet appartient ce fichier/cette commande ?

	which kwalletd5
	/usr/bin/kwalletd5
	dpkg -S /usr/bin/kwalletd5
	libkf5wallet-bin: /usr/bin/kwalletd5
	apt-rdepends -r libkf5wallet5


### reconstruire un paquet pour enlever une dépendance

Exemple avec Zoom et la dépendance de ibus

- Extraction du paquet :

      dpkg-deb --raw-extract zoom_amd64.deb new-zoom
 
- Modifier le fichier de contrôle :

      nano new-zoom/control/DEBIAN

  Enlever le dépendance ibus sur la ligne "Depends:"

- Reconstruire le paquet :

      fakeroot -- dpkg-deb --build new-zoom patched-zoom_amd64.deb