Changer l'identifiant du seul compte d'administrateur "bonjour"



    Robert redémarre l'ordinateur en mode **recovery**
    À l'invite de commande qui apparaît, Robert exécute les commandes suivantes :

        mount -o remount,rw /

        afin de pouvoir écrire sur le système de fichier

        root@ordinateur:~# usermod --login robert --home /home/robert --move-home bonjour


## Changer directement en 2 étapes

- se connecter en terminal **CTRL+ALT+F1**
- Activer *root* et redémarrer

		sudo passwd root
		sudo reboot

- se connecter en *root*, faire la modification, déactiver *root* et redémarrer

		root@ordinateur:~# usermod --login robert --home /home/robert --move-home bonjour
		passwd --lock root
		reboot

- Mofifier bookmarks

		sed -i -e 's;bonjour;robert;g' /home/robert/.config/gtk-3.0/bookmarks