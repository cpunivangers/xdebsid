## Installation xdebsid

Se connecter avec votre compte super-utilisateur (sudo) sur le poste en SSH ou en **console [CTRL]+[ALT]+[F1]**  

- Faire les mises à jour :

      sudo apt update && sudo apt -y dist-upgrade

- Si ce n'est pas la première installation de **xdebsid** ou de **madeb13** et pour une ré-initialisation complète (Firefox, XFCE), supprimer les 2 répertoires :

		rm -rf ~/.mozilla && rm -rf ~/.config/xfce4

- Installation de paquets utiles pour la suite :

      sudo apt -y install curl console-setup

- Récupération ansible pour xdebsid et installation de xdebsid (/opt/ansible/xdebsid) :

### en deux temps (recommandé):

- Téléchargement du script :

		wget https://raw.githubusercontent.com/cpunivangers/xdebsid/main/update_xdebsid.sh

- Redémarrage
- Se connecter sur le poste en SSH ou en **console [CTRL]+[ALT]+[F1]**
- Lancer le script :

		bash update_xdebsid.sh

### ou en automatique :

      curl -sL https://raw.githubusercontent.com/cpunivangers/xdebsid/main/update_xdebsid.sh | bash

## Principales opérations réalisées par le script :

- Mise à jour Debian
- Création d'un environnement virtuel python3 avec pip et ansible
- Téléchargement de la dernière version xdebsid : .aammjj.hhmn.tar.gz [https://github.com/cpunivangers/madeb13/releases/latest](https://github.com/cpunivangers/xdebsid/releases/latest)
- Extraction dans /opt/ansible/
- Exécution du playbook **xdebsid.yml** en local

## Autres opérations possibles :

- Si nécessaire, vous pouvez relancer la configuration **xdebsid** en tapant dans un terminal :

		xdebsid

- Mise à jour xdebsid et exécution :

	**xdebsid** est régulièrement mise à jour, vous pouvez mettre à jour votre machine en tapant dans un terminal :

		update_xdebsid
