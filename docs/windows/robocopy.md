## Sauvegarde avec robocopy :

Copie avec conservation des dates des répertoires :


	robocopy "c:\repertoire_source\nom_source" "d:\repertoire_destination\nom_source" /E /DCOPY:T 

Pour une copie miroir (suppresssion des fichiers qui ne sont plus dans la source) mettre l'option /MIR :


	robocopy "c:\repertoire_source\nom_source" "d:\repertoire_destination\nom_source" /MIR /DCOPY:T 