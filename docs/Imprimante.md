## Imprimante

### Détection des imprimantes

	sudo lpinfo -v

### Liste des imprimantes connectées

	lpstat -v

### Destination par défaut

	lpstat -d

Pour changer :

	sudo lpadmin -d Ixxxx

### les deux

	lpstat -s

### Liste des imprimantes en service

	lpstat -a

### Voir les options d'une imprimante

	sudo lpoptions -p Ixxxx -l

### Supprimer une imprimante

	sudo lpadmin -x Ixxxx
