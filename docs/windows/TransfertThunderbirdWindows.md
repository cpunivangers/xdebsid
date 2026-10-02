## Transfert Thunderbird Windows vers Debian

	rm -rf .thunderbird/
	cp -a SauvegardeConfigWindows202511/Thunderbird/ ~/.thunderbird
	cd ~/.thunderbird

- Lancer Thunderbird, cela créer un nouvel installation avec un nouveau profil.

- Supprimer les répertoires 'Crash Reports','Pending Pings'

- Supprimer les références à la nouvelle installation et au nouveau profil dans les fichier profiles.ini et installs.ini

- relancer Thunderbird et choisisser le profil.
