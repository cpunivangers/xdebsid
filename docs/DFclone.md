# Préparation Clé DFclone

## Installation DFiso 11.x.x sur le poste

[https://dflinux.debian-facile.org/isos/](https://dflinux.debian-facile.org/isos/) 

Nom Utilisateur : Bonjour (mdp Bonjour)
Identifiant : bonjour
Mot de passe : Bonjour

## Compléments madeb

### se connecter en mode terminal (Ctrl+Alt+F1)

*ou installer openssh-server et faire à distance*

	rm -rf ~/.config/xfce4/
	rm -rf ~/.mozilla/
	
	curl -sL https://uabox.univ-angers.fr/index.php/s/A529vAkMqi5X5n1/download | bash

## Modification manuelle


### Fond d'écran

remettre l'image "Debian Facile" du dossier **/usr/share/backgrounds/xfce**

## Clonage avec Clonezilla Live

Préparation du clonage :

	cd /opt/madeb
	sh prepclone.sh

Arrêter le pc

### Boot sur la clé Clonezilla

Faire une image du disque **DF11-img**

Mettre l'image sur la **clé de restauration DFclone**

### Clé de restauration DFclone

Suivre le document **ClonezillaLive.md**
