# systemd
Principales commandes pour gérer les programmes et services avec systemd
Rédigé par Cep - 29 avril 2016 - Aucun commentaire

Récapitulatif des principales commandes pour gérer les programmes et services avec systemd

Avec systemd on parle de services et units. Un unit peut être un service (*.service), un target (*.target), un montage (*.mount), un socket (*.socket)

Pour démarrer un service on utilise la commande :

	systemctl start programme.service

Par exemple 

	systemctl start apache2.service

On ajoute .service au nom du programme et la complétion automatique le fait pour nous mais la plupart du temps ce n’est pas nécessaire et l’on pourrait très bien utiliser indifféremment la commande :

	systemctl start programme

Pour arrêter un programme (service) la commande est :

	systemct stop programme.service

Pour relancer ou recharger un programme :

	systemctl restart programme.service

Ces commandes remplacent les anciennes :

	/etc/init.d/programme start   (ou restart)
ou

	service programme start (ou restart)
qui même si la plupart du temps sont encore reconnues un jour ou l’autre leur compatibilité ne sera plus assurée. Donc autant prendre les bonnes habitudes et être certain aussi que toute la chaîne systemd est assurée.

Pour recharger un programme :

	systemctl reload programme.service

Lorsqu’on ignore si le programme possède la fonction de rechargement on peut utiliser :

	systemctl reload-or-restart programme.service

Pour qu’un programme soit pris en charge automatiquement à chaque reboot :

	systemctl enable programme.service

Cette commande est en quelque sorte à rapprocher de l’ancienne update-rc,d et même remarque que ci-dessus sur sa compatibilité dans le temps.

Pour que le programme ne soit plus lancé automatiquement au boot :

	systemctl disable programme.service

Pour savoir quel est le status d’un programme :

	systemctl status programme.service

Pour savoir si un service est actif :

	systemctl is-active programme.service

De la même manière il existe les commandes is-enabled et is-failed

### Pour avoir la liste  de tous les units actifs :

	systemctl list-units

On a la même chose avec la commande systemctl sans autre option.

### Pour connaître la liste des units chargés et ceux en instance de chargement :

	systemctl list-units --all
	
	systemctl list-unit-files

### Liste des services
	systemctl list-units --type service

### Pour avoir des informations sur un unit particulier (depuis la version 209)
    systemctl cat programme.service

###Pour arrêter le système :
     systemctl halt
ou
    systemctl poweroff

###Pour le redémarrer :
    systemctl reboot

## Journal
###Pour visualiser :
    journalctl

### pour un seul service !
    journalctl -u programme

### Erreurs au boot
	sudo journalctl -p 3 -xb
	sudo journalctl -r -p err
  
## Audit
### service en erreur
    systemctl --failed
### plus de détails
    systemctl status programme.service
### Detail sur le processus nnn concerné
    sudo journalctl _PID=nnn

## Analyse temps de démarage
### temps total
    systemd-analyze time
### par services
    systemd-analyze blame
### Chemin critique
    systemd-analyze critical-chain

### analyser le démarrage d’un service
    journalctl -b -u programme.service

### Erreurs (-r = reverse = plus recentes à plus anciennes)
	journalctl -r -p err --no-pager

### Erreurs au démarrage
	journalctl -b -r -p err --no-pager

