##  KVM Partage de fichiers avec invité Windows


### Utilisation de Remmina comme client RDP sur la machine Windows

Avec le client Remmina, vous pouvez avoir un dossier partagé entre la machine hôte et la machine invité.  
Vous pouvez trouver l'adresse IP de votre machine virtuelle dans les infos de la carte réseau de votre machine KVM 192.168.122.xxx.


### Avec SSH : SSHFS Windows

[https://github.com/winfsp/sshfs-win](https://github.com/winfsp/sshfs-win)

Installer WinFsp et SSHFS-Win sur la machine.

Avec Winget dans un terminal en tant qu'administrateur :

	winget install -h -e --id "WinFsp.WinFsp" && winget install -h -e --id "SSHFS-Win.SSHFS-Win"

L'adresse IP de la machine hôte est normalement 192.168.122.1

Exemple accès au dossier linux **/home/c.pottier/TEMP**

#### par l'explorateur dans la barre d'adresse saisir le chemin :

	\\sshfs\c.pottier@192.168.122.1\TEMP

Vous pouvez ensuite épingler un dossier à l'accès rapide de l'explorateur.

#### par un mappage de lecteur réseau :

Connecter un lecteur réseau :

	Dossier : \\sshfs\c.pottier@192.168.122.1\TEMP
	
	Cocher "Se connecter lors de la connexion"

