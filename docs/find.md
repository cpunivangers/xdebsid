
#### fichiers modifiés dans /home/administrateur depuis la date du fichier /home/administrateur/.profile
	sudo find /home/administrateur -type f -newer /home/administrateur/.profile

#### sans les fichiers cachés
	sudo find /home/$UTIL -type f -newer /home/$UTIL/.profile -and -not -path \*/.\*
sudo find /home/$UTIL -type f -newer .profile -and -not -path \*/.\* -printf "%h/%f : Date modif =  %Td %Tb %TY\n" | more

sudo find /home/$UTIL -type f -newer /home/$UTIL/.profile -and -not -path \*/.\*

#### fichiers modifiés depuis 90j
sudo find /home/nekka -mtime -90 -type f
find . -mtime -90 -type f -printf "%h/%f : Date modif =  %Td %Tb %TY\n" | more

#### recherche chaine dans fichiers en récursifs
grep -nri "texte"

#### recherche et remplace
sudo grep -rlZ "home/administrateur" | xargs -r0  sudo sed -i -e "s:home/administrateur:home/etudiant:g"

#### Doublons
 sudo fdupes -rA . > doublon.txt

#### exec
find . -name "wget*.sh" -exec grep "curl" {} \;
find . -name "wget*.sh" -exec grep -H "curl" {} \;

#### Compter les fichiers :
ls -1R /media/DATA/Pictures | wc -l
ls -1R /media/DATA/Pictures | grep -c \.jpg$

#### Compter les fichier par extension
find /media/DATA/Music -type f | sed -n 's/..*\.//p' | sort | uniq -c
