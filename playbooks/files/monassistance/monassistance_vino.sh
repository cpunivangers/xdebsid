#!/bin/sh
 
# 29/02/2016
# christian.pottier@univ-angers.fr
# Vino : Bureau à distance par tunnel SSH

gsettings set org.gnome.Vino notify-on-connect true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino network-interface 'lo'
# Verif
#gsettings list-recursively org.gnome.Vino
#netstat -nlp | grep ':5900'
#
# Lancement du serveur
/usr/lib/vino/vino-server &