#!/bin/sh
 
# 03/2023
# christian.pottier@univ-angers.fr
#  
# Vérouille le tableau de bord

sudo cp  ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/
sudo sed -i '/<channel/ s/>/ locked="*" unlocked="root">/' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
pkill xfconf
xfce4-session-logout --fast --logout
