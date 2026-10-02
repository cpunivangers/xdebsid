# pentablet-driver.deb

**Objectif :**
	Utilisation conjointe du pilote officiel pour les tablettes XP-PEN et des outils Wacom

## Installation du paquet avec résolution des dépendances :

	sudo apt install ./pentablet-driver.deb


L'installation :

- Télécharge le pilote officiel
- Décompresse le pilote dans  /opt/Pentablet-Driver
- Ajoute la tablette pour les outils wacom (/etc/X11/xorg.conf.d/50-pentablet.conf)
- Rend le pilote accessible pour tous.
- Ajoute l'application **Pentablet-Driver.desktop**
- Ajoute la commande **xinput_calibrator2xsetwacom** pour faciliter la calibration

**Redémarrer votre ordinateur.**

## L'application Pentablet-Driver.desktop :

- Lance l'outil : /usr/local/bin/Pentablet-Profil [profil]
	- Les profils sont stockés dans ~/.config/Pentablet
	- Chaque profils est un dossier
	- Un dossier Default est crée au premier lancement ~/.config/Pentablet/Default.
	- Le dossier du profil contient le fichier config.xml pour le pilote XP-PEN Tablet et un script xsetwacom.sh si nécessaire.
	- Si un nom de profil est passé à la ligne de commande, il sera utilisé (s'il n'existe pas, il est crée à partir du profil Default) :

			/usr/local/bin/Pentablet-Profil MonProfil2

- Lancement du pilote avec le fichier config.xml du profil et minimisation de la fenêtre.

- Si un script xsetwacom.sh est trouvé dans le profil, il est executé.

- A la fermeture du pilote le fichier config.xml est sauvegardé dans le profil.


## Script de configuration :

Le calibrage va varier en fonction de la configuration matériel (Ecrans, branchement de la tablette ...)

- Mettre la tablette en **miroir de l'écran**

- **Lancement de l'application Pentablet-Driver**
- Dans le pilote, mettre **Mapping sur AllSreen** et sauvegarder.

- Ouvrir un terminal

	**Mappage de l'écran**

    pour repérer l'écran de la tablette lancer la commande :

		xrandr

	Exemple mappage avec le 2ème display port :

		xinput --map-to-output "XPPEN Tablet stylus" DP-2
		xsetwacom set "XPPEN Tablet stylus" MapToOutput DP-2

	**Calibration**

	Lancer la calibration :

		xinput_calibrator --device "XPPEN Tablet stylus"

	pour xsetxacom area = MinX MinY MaxX MaxY

		xsetwacom set "XPPEN Tablet stylus" area -238 89 31663 25027
		
	Pouvez aussi utiliser la commande **xinput_calibrator2xsetwacom** qui affiche la commande xsetwacom après calibration et l’exécute.

	Quand le calibrage vous convient, enregistrer les commandes dans le script :

		echo 'xinput --map-to-output "XPPEN Tablet stylus" DP-2' > ~/.config/Pentablet/Default/xsetwacom.sh
		echo 'xsetwacom set "XPPEN Tablet stylus" MapToOutput DP-2' >> ~/.config/Pentablet/Default/xsetwacom.sh
		echo 'xsetwacom set "XPPEN Tablet stylus" area -238 89 31663 25027' >> ~/.config/Pentablet/Default/xsetwacom.sh

- fermer l'application Pentablet

**Si vous êtes dans les mêmes conditions matériels**, lorsque vous relancerez l'application, vous retrouverez votre configuration automatiquement.

