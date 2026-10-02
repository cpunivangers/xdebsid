
sysreseau.net
chattr : Protéger vos fichiers Linux
admin
3-4 minutes

chattr est une commande sous linux qui vous permet de définir des attributs sur un fichier ou dossier pour les protéger. Si plusieurs personnes accède à votre serveur Linux et y travaille ensemble sur plusieurs fichiers, c’est fort probablement qu’il y aura des suppressions accidentelles ou d’édition des fichiers importants, an tant qu’administrateur vous n’aimeriez certainement pas que cela arrive.

Heureusement il existe une commande sous linux appelé chattr développée pour éviter ce genre de scénario.
Dans cet article nous allons voir comment utiliser cette commandes avec des exemples simple à comprendre.
Mettre un fichier en Lecture seule ( read-only) avec chattr

Supposant que vous souhaitez mettre un fichier en read-only, il suffit de lui ajouter l’attribut +i :

[root@Linux ~]# chattr +i file1

Essayez de modifier le fichier, vous aurez un message d’erreur : « Permission non accordée »
chattr

je ne peux même pas le supprimer :
chattr

Remarquez que même si je suis root je n’ai pas pu modifier ou supprimer le fichier, elle est forte cette commande n’est ce pas 🙂 .
Supprimer la restriction read-only avec chattr:

Il suffit d’utiliser l’option -i au lieu de +i :

[root@Linux ~]#chattr -i file1


Un fichier avec l’attribut append « a » ne peut être ouvert qu’en mode ajout pour l’écriture. cela veut dire que vous ne pouvez pas supprimer ou éditer les informations existante du fichier, vous avez le droit seulement d’en y ajouter.
Ajouter l’attribut append :

[root@Linux ~]# chattr +a file1
[root@Linux ~]# echo "Hello" >> file1
[root@Linux ~]# cat file1
Sysreseau.net
Hello
[root@Linux ~]# echo "Text" > file1
-bash: file1: Operation not permitted

[root@Linux ~]# rm -rf file1
rm: cannot remove `file1': Operation not permitted

Supprimer l’attribut append :

[root@Linux ~]# chattr -a file

Appliquer une restriction à tous les fichier d’un répertoire et sous répertoire:

Pour ajouter un attribut à plusieurs fichiers d’un répertoire, il suffit d’ajouter l’option -R :

[root@Linux ~]# chattr -R +i test/
[root@Linux ~]# cd test/
[root@Linux test]# ll
total 4
-rw-r--r--. 1 root root 0 Apr 20 10:58 file1
-rw-r--r--. 1 root root 0 Apr 20 10:58 file2
-rw-r--r--. 1 root root 0 Apr 20 10:58 file3
-rw-r--r--. 1 root root 0 Apr 20 10:58 file4
drwxr-xr-x. 2 root root 4096 Apr 20 10:59 Class
[root@Linux test]# rm -rf *
rm: cannot remove 
file1': Permission denied rm: cannot remove
file2': Permission denied
rm: cannot remove 
file3': Permission denied rm: cannot remove
file4': Permission denied
rm: cannot remove 
Class/file2': Permission denied rm: cannot remove
Class/file1': Permission denied

Comme vous pouvez le constater l’attribut « i » a été appliqué à tous les fichiers du répertoire « test » et sous répertoire « Class ».

Pour vérifier si des attributs sont appliqués sur un fichier il suffit de taper la commande lsattr :

[root@Linux Linux]# lsattr
----i--------e--- ./file2
----i--------e--- ./repertoire
----i--------e--- ./file4
----i--------e--- ./file1
----i--------e--- ./file3

Comme vous pouvez le constater c’est l’attribut « i » qui est appliqué sur ces fichier.
