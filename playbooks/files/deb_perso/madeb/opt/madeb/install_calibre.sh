#!/bin/bash
 
# 04/02/2025
# christian.pottier@univ-angers.fr
#
# https://calibre-ebook.com/fr/download_linux

sudo apt install -y libxcb-cursor0

sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

