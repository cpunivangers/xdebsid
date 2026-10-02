#!/bin/bash
# Installation de mon assistance en ssh
# 30/09/2016 chris.pottier@free.fr

## Vos infos a renseigner :
# Votre nom ou adresse courriel
MONASSISTANCE_NOM="chris.pottier@free.fr"
# L'adresse IP publique ou nom de domaine :
MONASSISTANCE_IP="88.186.175.94"
# Port de redirection pour le port ssh
MONASSISTANCE_REDIRECT="22222"
# Port de redirection pour le port ssh
MONASSISTANCE_PORTSSH="22"
# L'utilisateur qui se connecte à cette adresse
MONASSISTANCE_USER="monassistance"
# La clé privé pour ne pas saisir de mot de passe de l'utilisateur
MONASSISTANCE_CLE="-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAmxDWuiG1Kqvy5pK5zFZh+qBV/MJ3QRtfGrMiHkD1IGh/qR5G
NY76oRT3Cku/QCxkQEDnwop38dbXrDlpYKVWvQZ2uz0iZ3RtgBv258IOWWVt6gNs
rKmPbu1+JXZ8TS5y+udDrVS/B7O9J2rAii5wMa6GH5fkE1E3qU2xg6W1GgDYvZu6
3UOhG0ncvdUglqX6HwGiDxZ+SHmWo2KnW7ulvI/2X+rLOMd0HIVN2UaFtXfRCWg7
bNpvUmGC+H2yUzJlUbcdW2sy346aleGybdVP9ToCiVcoOa+7m5/kJsBYOQd9Pr2+
gnFucsFQC6VNEZJ1Jk7sTRKa5VNcmARKyYMnYwIDAQABAoIBADbYgdpbycRKBSPg
ia7obsdCpqc78QoqMD01Vr/0ob7QtzaN6q9O3v7Sd35AxGhiSyMe0dpRN5NmNepI
dCkm0cMR4jTfrqeA2qoROgdG7+RWp8W5aFq5rm3BunhtrBFweGKeIaXQ77A9to2W
iHtXaX9pBy9tfdIHS/Sp8jtqBOApF4F1s5NQhL4aDZb5hZOtBeHp7qokbNIRG6Fo
KLr2PdRq/5GFWCHlko6hfZ9PDhcxyMhYc1xLLHRjkdPWsKr81sIBCVTwR++K18FZ
kH6hpft1uzBx2J5GsqrD0MfVVBKRCUvah0kxL1bTdMnZtdWA849Sj3RSSTzCW+4k
TtctMwECgYEAzL7I7ql0D7tYfkur9SDiUOTjplVTWCSGwLuhcav8zhlyQQXuOWdM
TxQY+AXbO3G1T7pr+nFvSSTT3A+5wZXsVs5dOGwVdRypaNsuA7a8NDycMLYOQKF4
PyrU5jcnyN558xBe8/3DAeT5Xx0iK+z19PAwupqg4cZU1VfudFvvRQMCgYEAweJR
CpFUlMqkJxUA4AnQRzZR7YtX5q0YA1WqvqRQs+ngewiPZHU5AhZh3Nz0IcZNITPC
YvH7J5iuDX4TGSRR1RjYVVdOtSYgy6LrrWNFw3H7cYqxMUdh1yl3JqA7hr2VUPaf
QN5xGhO8altsNKIg+RLuMDUZAB9aJEpgLMw/FiECgYBJ7Q0B119Xms5t84aoIHJ2
wN5NnXtVVQLurhCxyWajR97QCYMlaN3No7UMQJkS0pCjs+zu5WxIHar9RxRMCITo
JuTTzXrF6U5l1NW9c4pq1gOTNvjYbzTKof1zDjEoPuQLVjrioBp8IZ/ErvE6qPl5
sgv2JIS4YHMbAP/RNayj3wKBgQCIzgtG/KME1jObzAsxClunU+HdTlw4zVxLRhBT
sperS1R1G+YqCTivi2GEOXgduNHFosL/lCUWnHn71UDela0UQxKqrQ9BbOTpK01G
q+yW6v9z71v2HJsh+gU0AQ3fljgcx9g5Knv93X0uQtIIFXpUpZHh/CVm27h8MOrJ
0ViWYQKBgA6X8nRDlociAjUNGxInELrpkkbwNxOaiCm4sOtawh6KNDcWapyvlQXi
CVCkNMWekYSBlJC6eT/aWEJLgYCERjk3v6zeo+7qmLPB7mRIZCClwUogwdIYu8Gj
q0/5+FOtvzl3MhlmAlCb+KiT1HFDjyQAvfCoqsJV9pJuRxCfsZyc
-----END RSA PRIVATE KEY-----
"
##

# Installation des paquets nécessaires
sudo apt-get -y install autossh openssh-server zenity
# Pour le bureau à distance
sudo apt-get install vino dconf-editor

#Creation du dossier de stokage des infos (au cas où il n'existe pas encore)
sudo mkdir -p /etc/monassistance

# Infos : nom Ip user assistance
echo "MONASSISTANCE_NOM=$MONASSISTANCE_NOM" | sudo tee /etc/monassistance/monassistance_infos
echo "MONASSISTANCE_IP=$MONASSISTANCE_IP" | sudo tee -a /etc/monassistance/monassistance_infos
echo "MONASSISTANCE_REDIRECT=$MONASSISTANCE_REDIRECT" | sudo tee -a /etc/monassistance/monassistance_infos
echo "MONASSISTANCE_PORTSSH=$MONASSISTANCE_PORTSSH" | sudo tee -a /etc/monassistance/monassistance_infos
echo "MONASSISTANCE_USER=$MONASSISTANCE_USER" | sudo tee -a /etc/monassistance/monassistance_infos
# Copie de la clé
echo "$MONASSISTANCE_CLE" | sudo tee /etc/monassistance/monassistance_cle

# Création du script d'assistance

echo '#!/bin/bash

. /etc/monassistance/monassistance_infos

IP_ASSISTANCE=` zenity --entry \
--title="Assistance à distance $MONASSISTANCE_NOM" \
--text="Saisissez Adresse IP ou le nom de domaine :" \
--entry-text "$MONASSISTANCE_IP" `

if [ -z "$IP_ASSISTANCE" ]; then
	zenity --notification --window-icon="error" --text="Aucune adresse saisie !"
else
	monassistance_vino.sh
	autossh -f -o "StrictHostKeyChecking no" -i /etc/monassistance/monassistance_cle -NR $MONASSISTANCE_REDIRECT:localhost:$MONASSISTANCE_PORTSSH $MONASSISTANCE_USER@$IP_ASSISTANCE
	zenity --notification --window-icon="info" --text="Assistance $MONASSISTANCE_NOM lancée. $IP_ASSISTANCE"
fi' | sudo tee /usr/local/bin/monassistance.sh

sudo chmod +x /usr/local/bin/monassistance.sh

echo '#!/bin/bash

gsettings set org.gnome.Vino notify-on-connect true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino network-interface "lo"
# Lancement du serveur
/usr/lib/vino/vino-server &
exit' | sudo tee /usr/local/bin/monassistance_vino.sh

sudo chmod +x /usr/local/bin/monassistance_vino.sh


# Création du raccourci dans les applications
echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/usr/local/bin/monassistance.sh
Name=Assistance $MONASSISTANCE_NOM
Categories=Application;System;
Icon=help" | sudo tee /usr/share/applications/monassistance.desktop
sudo chmod +x /usr/share/applications/monassistance.desktop

# Copie sur le bureau
cp /usr/share/applications/monassistance.desktop $(xdg-user-dir DESKTOP)/
chmod +x $(xdg-user-dir DESKTOP)/monassistance.desktop

exit
