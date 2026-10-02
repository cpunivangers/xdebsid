# Assistance à distance avec un reverse ssh 

## Creation sur ma machine d'un utilisateur avec des droits limités

### Sans home sans clé ssh
	sudo useradd -M -c "mon assistance" -p $(mkpasswd Arrakis) -s /bin/false monassistance

### Avec home et clé ssh	
	sudo useradd -m -c "mon assistance" -p $(mkpasswd ****) -s /bin/bash monassistance

## Sur la machine distante
	ssh -nNT -R 22222:localhost:22 monassistance@mon_ip_publique
	
ou pour éviter la confirmation d'un nouvelle machine

	ssh -o "StrictHostKeyChecking no" -nNT -R 22222:localhost:22 monassistance@mon_ip_publique

*n* Sert pour éviter d’afficher des choses sur son terminal n’affiche rien (envoie vers /dev/null)
*N*  Sert pour préciser de ne pas utiliser la ligne de commande,   une fois connecté, il ne dira rien.
*T* Sert à ne pas allouer de pseudo terminal (pseudo-tty)
*R* Sert a préciser un Tunnel inversé (Reverse) qui servira a exposer le port 22 à partir du port 22222 de ma machine.


## Sur mon poste :
	ssh -p 22222 utilisateur_distant@localhost

## Pour éviter la saisie du mot de passe par la machine distante :

### Clé SSH
Création clé publique "monassistance_cle.pub" et privé "monassistance_cle"

	ssh-keygen -C monassistance -f monassistance_cle

### sur la machine distante

**
Pour une installation automatique sur un poste distant, vérifier les infos et executer le script : install_monassistance.sh
**
Mettre la clé privé dans /etc/monassistance/monassistance_cle

### sur mon poste mettre la clé publique :

	ssh-copy-id -i monassistance_cle.pub monassistance@ip_de_ma_machine

### tester l'accés sans mot de passe
	ssh -i /etc/monassistance/monassistance_cle monassistance@ip_de_ma_machine

## IMPORTANT : Supprimer l'acces au shell sur ma machine pour "monassistance"

	sudo usermod monassistance -s /bin/false

## Sur la machine distante :
ssh -i /etc/monassistance/monassistance_cle -nNT -R 22222:localhost:22 monassistance@ip_de_ma_machine

## Avec autossh sur le poste distant pour éviter la perte du tunnel ssh

	sudo apt-get install -y autossh
	autossh -f -o "StrictHostKeyChecking no" -i /etc/monassistance/monassistance_cle -NR 22222:localhost:22 monassistance@ip_de_ma_machine


## Partage du bureau sur la machine distante si "install_monassistance.sh" ne le fait pas
sudo apt-get install vino dconf-editor
#pour partager le bureau mettre le script monassistance_vino.sh dans /usr/local/bin/
sudo install monassistance_vino.sh /usr/local/bin/
# Partage du bureau de la machine distante après connection en SSH (ssh -p 22222 utilisateur_distant@localhost) :
DISPLAY=:0 /usr/local/bin/monassistance_vino.sh
# Sur ma machine avec remmina (sudo apt-get install -y remmina remmina-plugin-*) :
Protocole : VNC
Serveur : localhost
Activer le Tunnel SSH
Personnalisée : localhost:22222
Nom d'utilisateur : utilisateur_distant

ou copier
cp monassistance.remmina ~/.remmina/

