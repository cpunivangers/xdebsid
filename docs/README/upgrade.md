# Mise à niveau madeb13 vers xdebsid

Mise à niveau de votre Debian 13 (madeb13) vers Debian Sid (xdebsid)  

**Attention** Une mise à jour nécessite beaucoup d'espace.  
Vérifier l'espace disponible sur votre racine “/” avec la commande :  

	df h

## Sauvegarde

Vous devez au préalable sauvegarder vos données (/home) et fichiers de configuration si nécessaire.

Infos utiles :

[https://debian-facile.org/doc:migrer](https://debian-facile.org/doc:migrer)

[https://www.debian.org/News/2025/20250809](https://www.debian.org/News/2025/20250809) paragraphe "Mise à niveau"

[https://fr.wikitwist.com/mettre-a-jour-debian-12-vers-debian-13-trixie-guide-pas-a-pas/](https://fr.wikitwist.com/mettre-a-jour-debian-12-vers-debian-13-trixie-guide-pas-a-pas/)

## Script de migration (NON GARANTIE !)

- Installation de paquets utiles pour la suite :

      sudo apt -y install curl console-setup

- Pour une ré-initialisation complète de XFCE, supprimer le répertoire :

		rm -rf ~/.config/xfce4

### en deux temps (recommandé):

- Téléchargement du script

      wget https://raw.githubusercontent.com/cpunivangers/xdebsid/main/playbooks/files/Divers/xdeb13toxdebsid.sh

- Redémarrage
- Se connecter sur le poste en SSH ou en **console [CTRL]+[ALT]+[F1]**
- Lancer le script :

		bash xdeb13toxdebsid.sh

### ou en automatique :

      curl -sL https://raw.githubusercontent.com/cpunivangers/xdebsid/main/playbooks/files/Divers/xdeb13toxdebsid.sh | bash

## Principales opérations réalisées par ce script :

### Préparation

- Suppression des éléments madeb13
- Purge de divers paquets pouvant poser problèmes.
- Téléchargement de xdebsid
- Extraction dans /opt/ansible/
- Déplacement des dépôts annexes vers /etc/apt/sources.list.d13
- Mise à jour de la Debian 13
- Nettoyage

### Mise à niveau vers Debian Sid

- Mise à jour du sources.list par celui de la Debian Sid
- Affichage de l'espace disque nécessaire pour le téléchargement des paquets.
- Mise à jour
- Exécution du playbook **xdebsid.yml** en local

## Redémarrer le poste

Vous pouvez mettre à jour vos logiciels de dépôts annexes, si nécessaire.

