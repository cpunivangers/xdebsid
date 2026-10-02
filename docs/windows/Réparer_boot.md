Réparation Windows 8 suite à une erreur au boot (BCD)

Dans le mode "recovery" Alt +F10

## Avant

> Dépannage > Options avancées > Invite de commandes

BOOTREC /FIXMBR

BOOTREC /FIXBOOT

BOOTREC /REBUILDBCD

exit

## Maintenant Bcdedit impossible d’ouvrir le magasin des données de configuration de démarrage.


x:\Sources>bcdedit /v
Impossible d'ouvrir ...

### Réparation rapide avec bcdboot

**Commande à faire maintenant**

	bcdboot C:\Windows /l f-fr
	bcdedit /v

Si le démarrage est réparé alors l’erreur bcdedit ne s’affiche plus.
Redémarrez le PC et relancez Windows.

[https://www.malekal.com/bcdedit-impossible-ouvrir-magasin-donnees-windows-10/](https://www.malekal.com/bcdedit-impossible-ouvrir-magasin-donnees-windows-10/)


# réparer disque
# boot windows 10 usb ou dvd
# Invite de commande
# https://www.forum-des-portables-asus.fr/forums/threads/windows-10-ne-demarre-plus-avec-cle-de-reboot.15868/print
# Une invite de commande apparaît, tapes
diskpart
#une fois diskpart lancé, tapes:
lis dis 
# Une liste de disques d'affiche, chacun relié à un chiffre. Tape ensuite:
sel dis X
# où X est le chiffre du disque sélectionné.
# Une fois le disque sélectionné, tapes:
Lis par 
# Suis la même procédure pour chaque disque.
# A la fin, tapes:
lis vol
exit

# Après avoir quitté Diskpart, tapes, toujours dans l'invite de commandes, la commande suivante avec la lettre du disque à vérifier:
chkdsk c: /f /r




