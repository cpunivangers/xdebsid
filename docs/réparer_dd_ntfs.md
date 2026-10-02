Sauvegarder le contenu de votre disque dur sur un autre support et installer badblocks sur votre système (c'est un utilitaire inclus dans le paquet e2fsprogs).
Détection et signalement des secteurs défectueux

Lancer badblocks pour scanner votre partition à la recherche des secteurs défectueux (NB : cette opération prend du temps). Cela se fait avec la commande :
sudo badblocks /dev/sdc1 (remplacer « sdc1 » par votre numéro de partition).

Si comme moi vous risquez d'avoir un certain nombre de secteurs défectueux, le plus simple est de les reporter dans un fichiers texte, ce qui peut être fait automatiquement en remplaçant la commande précédente par celle-ci :
sudo badblocks /dev/sdc1 > /home/mon_home/bad-blocks.txt (remplacer « sdc1 » par votre numéro de partition et « mon_home » par le nom de votre répertoire home).

Badblocks va alors vous révéler les adresses des secteurs défectueux, par exemple :
100390264
100390265
100390266
100390267
146565556
146565557
...

L'étape suivante va consister à écrire sur les secteurs défectueux. En reprenant l'exemple ci-dessus, cela donne :
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=100390264
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=100390265
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=100390266
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=100390267
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=146565556
sudo dd if=/dev/zero of=/dev/sdc1 bs=1024 count=1 seek=146565557

Le reste est normalement pris en charge par le contrôleur du disque qui remarquera ainsi que ces secteurs sont défectueux et en tiendra compte à l'avenir !
Vérification, restauration

Pour vous assurer de la réussite de l'opération, relancer la commande du début (sudo badblocks /dev/sdc1) : vous ne devriez plus avoir d'erreur à présent. Il est temps de restaurer les données de votre disque dur :)