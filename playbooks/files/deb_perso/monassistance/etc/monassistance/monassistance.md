# Assistance à distance avec un reverse ssh 

## Sur les machines, installer le paquet monassistance.deb

## Sur ma machine

### Création de l'utilisateur monassistance avec des droits limités (avec home pour les clés ssh)

	sudo useradd -m -c "mon assistance" -p $(mkpasswd Arrakis) -s /bin/bash monassistance

### Mettre la clé publique :

	ssh-copy-id -i /etc/monassistance/monassistance_cle.pub monassistance@localhost

### Tester l'accés sans mot de passe

	ssh -i /etc/monassistance/monassistance_cle monassistance@localhost
	
### IMPORTANT : Supprimer l'acces au shell sur ma machine pour "monassistance"

	sudo usermod monassistance -s /bin/false

### Si lancement manuel sur la machine distante :
	ssh -i /etc/monassistance/monassistance_cle -nNT -R 22222:localhost:22 monassistance@ip_de_ma_machine
	
#### sur un poste windows :

	ssh -NR 22222:localhost:22 monassistance@ip_de_ma_machine

### Voir la connexion

		ps -u monassistance

### Connexion SSH sur le poste distant :
	ssh -p 22222 utilisateur_distant@localhost


### Connexion Bureau distant sur le poste distant avec remmina (sudo apt-get install -y remmina remmina-plugin-*) :

#### Poste distant Linux

Sur le poste distant par ssh, lancer le serveur vino pour le bureau distant :

	monassistance_vino

Config pour remmina :

	Protocole : VNC
	Serveur : localhost
	Activer le Tunnel SSH
	Personnalisée : localhost:22222
	Nom d'utilisateur : utilisateur_distant

ou copier

	cp /etc/monassistance/monassistance.remmina ~/.local/share/remmina/

#### Poste distant Windows
Config pour remmina :

	Protocole : RDP
	Serveur : ::1
	Activer le Tunnel SSH
	Personnalisée : localhost:22222
	Nom d'utilisateur : utilisateur_distant
	