#!/bin/sh -e
 
# 05/2013
# christian.pottier@univ-angers.fr
# 
# autologin Debian 9

# config lightdm

if [ -z $1 ]; then
	UTIL=$USER
	read MACHINE
else
	UTIL=$1
fi

sudo sed -i -e "s/^autologin-user=.*$/#autologin-user=/" /etc/lightdm/lightdm.conf
sudo sed -i -e "s/^autologin-user-timeout=.*$/#autologin-user-timeout=0/" /etc/lightdm/lightdm.conf

if [ "$UTIL" = "off" ] ; then
	exit
fi
sudo sed -i -e "s/^#autologin-user=.*$/autologin-user=$UTIL/" /etc/lightdm/lightdm.conf
sudo sed -i -e "s/^#autologin-user-timeout=.*$/autologin-user-timeout=0/" /etc/lightdm/lightdm.conf
