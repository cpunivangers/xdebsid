# Pas de Par-feu

## Pas de pare-feu si aucun ports ouverts !

Listes des ports ouverts

	sudo lsof -nP -iTCP -sTCP:LISTEN

ou

	sudo netstat -tulnp

ou

	sudo ss -tulnp

Les services qui écoutent en local ne présente aucun risque (cupsd)

Si des ports sont ouverts, c'est qu'ils sont peut-être utiles (sshd)

Le risque est nul derrière sa box qui fait pare-feu.

Pour accéder à une machine, il faut être sur le même réseau !

En wifi, il faut déjà que l'attaquant craque le réseau wi-fi.

Sur un wifi publique mal configuré (très rare), désactivé les services concernés (ssh)

	sudo systemctl stop ssh.service