#!/bin/sh
 
# 03/2011
# christian.pottier@univ-angers.fr
#  
# preparation clonage ou remastersys ...

sudo cp -f post_clone.sh /etc/
sudo cp -f pre_clone.sh /etc/
sudo rm -f /var/log/postclone.log 
sudo sh /etc/pre_clone.sh

