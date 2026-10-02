#!/bin/sh
 
# 03/2023
# christian.pottier@univ-angers.fr
#  
# Dé-Vérouille le tableau de bord

sudo rm /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
pkill xfconf
xfce4-session-logout --fast --logout
