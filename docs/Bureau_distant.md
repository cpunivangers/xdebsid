# Bureau à distance

## xRDP

Facile à installer et compatible avec tous les clients RDP.

	sudo apt install xrdp -y
	sudo systemctl status xrdp
	sudo adduser xrdp ssl-cert
	sudo systemctl restart xrdp

Si vous le souhaitez, activez le démarrage automatique du service xRDP :

	sudo systemctl enable xrdp

Sécurisé avec un tunel ssh.

## xpra

Installation :

	sudo apt install xpra
	
Utilisation :

	xpra start-desktop --start-child=xfce4-session --exit-with-children ssh://user@ip/