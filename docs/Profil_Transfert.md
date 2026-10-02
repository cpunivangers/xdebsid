# Transfert d'un Profil

## Transfert par tar

### Sur l'ancien disque

	cd /home
	UTIL=j.cowles
	sudo tar  --exclude={"ImapMail",".cache",".Cache,Cache","Trash"} --one-file-system --ignore-case -zcvf $UTIL.tar.gz $UTIL
	scp $UTIL.tar.gz administrateur@xxx.xx.xx.xx:

### Sur le nouveau disque
	UTIL=j.cowles
	sudo mv $UTIL.tar.gz /home/
	cd /home/
	sudo tar xzvf $UTIL.tar.gz

