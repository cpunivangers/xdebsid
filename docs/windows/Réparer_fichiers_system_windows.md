## vérification de fichiers système pour réparer les fichiers système manquants ou corrompus

### Étape 1 : Exécuter DISM en tant qu'administrateur.

	DISM.exe /Online /Cleanup-image /Restorehealth


### Étape 2: Vérificateur de fichier du système

	sfc/scannow


[https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e](https://support.microsoft.com/en-us/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e)