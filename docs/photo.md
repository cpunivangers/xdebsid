# récupérer les photos
# en ligne de commande
gphoto2
# graphique
rapid-photo-downloader
# https://lephotographelibre.wordpress.com

# Gestionnaire
gthumb
shotwell
digikam
XnViewMP

#Retouches / Montage
gimp

# jhead : renommage

Renommer des photos qui sont dans le répertoire /home/martine/Photos (le répertoire est visible dans le gestionnaire de fichiers).

	cd /home/martine/Photos
	shopt -s nocaseglob
	jhead  -nf%Y-%m-%d--%H.%M.%S *jpg

shopt -s nocaseglob évite d'avoir à se soucier des majuscule / minuscules.

La commande jhead permet de renommer (-nf)tous les fichiers JPEG.

-  %Y : l'année de la prise de vue sur 4 caractères (ex: 2010)
-  %m : le mois sur 2 caractères (ex: 03 pour mars)
-  %d : le jour dans le mois sur 2 caractères (02 pour le 2 mars)
-  %H : l'heure sur 2 caractères
-  %M : les minutes sur 2 caractères
-  %S : secondes sur 2 caractères

Pour une photographie prise le 2 mars 2010 à 14:06:12, le fichier sera nommé 2010-03-01–14.06.12.jpg.

Si plusieurs photos ont été prises dans la même seconde (mode rafale d'un appareil photo ou plusieurs appareils photo), jhead ajoutera un lettre à la fin du fichier en commençant par a. 