# Compactage disque dynamique VDI

## Espace vide à zéro

### Sous Linux

   1. lancez un terminal ;
   2. exécutez la commande cat /dev/zero > zeros ; sync ; rm zeros pour créer un fichier qui occupera tout l’espace libre en étant rempli de zéros et sera ensuite effacé.

### Sous Windows

   1. Défragmenter le disque
   2. lancez une invite de commandes ;
   3. Utiliser sdelete [https://download.sysinternals.com/files/SDelete.zip](https://download.sysinternals.com/files/SDelete.zip)
   
		c:\SDelete\sdelete c: -z

**Patientez !!!**

## Compactage du VDI

   1. lancez un terminal dans le répertoire du disque VDI
   2. exécutez la commande :

		VBoxManage modifymedium disk ./I-COURS.vdi --compact
