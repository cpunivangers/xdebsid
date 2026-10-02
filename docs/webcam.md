# webcam

## Dépendances

	sudo apt install v4l-utils qv4l2
	sudo apt install guvcview

## Pb résolution webcam

### Liste des résolutions

	v4l2-ctl -d /dev/video0 --list-formats-ext

### Détails webcam

	v4l2-ctl -d /dev/video0 -V

### Forcer la résolution et format

En ligne de commande :  

	v4l2-ctl -d /dev/video0 -v width=1280,height=720,pixelformat=MJPG

Ou avec **guvcview**