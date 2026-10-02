Cloner à travers ssh

Si on veut s'éclater à copier une machine sur une autre, on peut démarrer les 2 machines sur un live CD.
Sur la machine de destination, on définit un mot de passe à root et on démarre le serveur SSH.

Si les 2 disques s'appellent /dev/sda, on pourra cloner depuis la machine source via :
Copier vers le presse-papierCode BASH :

dd status=progress if=/dev/sda bs=100M | ssh machinedistante  'dd of=/dev/sda'





On peut le faire avec cat, qui est plus rapide :
Copier vers le presse-papierCode BASH :

cat /dev/sda | ssh 10.21.21.231  'cat > /dev/sda'



Si vous avez pv à votre disposition, pour suivre l'avancée :
Copier vers le presse-papierCode BASH :

pv /dev/sda | ssh 10.21.21.231  'cat > /dev/sda'
