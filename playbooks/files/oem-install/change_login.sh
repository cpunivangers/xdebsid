#!/bin/bash
 
# 10/2023
# christian.pottier@univ-angers.fr
# Changement de l'indentifiant principal

# on supprime la tache au demarrage
if [ -f /etc/rc.local.svg ]; then
	cp -f /etc/rc.local.svg /etc/rc.local
	chmod -x /etc/rc.local
else
	rm /etc/rc.local
fi

OLD_LOGIN=$(id -un -- 1000)
NEW_LOGIN=""
if [ -f /var/NEW_USERNAME ]; then
	source /var/NEW_USERNAME
else
	exit
fi

if [ -z "$NEW_LOGIN" ] ; then
	NEW_LOGIN=$OLD_LOGIN
fi
echo "$OLD_LOGIN => $NEW_LOGIN"
if [ "$OLD_LOGIN" = "$NEW_LOGIN" ] ; then
	rm -f /var/NEW_USERNAME
	exit 0
fi

usermod --login $NEW_LOGIN --home /home/$NEW_LOGIN --move-home $OLD_LOGIN

rm -rf /home/$NEW_LOGIN/.Xauthority
rm -rf /home/$NEW_LOGIN/.xsession-errors*
rm -rf /home/$NEW_LOGIN/.cache

grep -rlZ "home/$OLD_LOGIN" /home/$NEW_LOGIN | xargs -r0  sed -i -e "s:home/$OLD_LOGIN:home/$NEW_LOGIN:g"

grep -rlZ "= $OLD_LOGIN" /home/$NEW_LOGIN | xargs -r0  sed -i -e "s:= $OLD_LOGIN:= $NEW_LOGIN:g"
grep -rlZ "=$OLD_LOGIN" /home/$NEW_LOGIN | xargs -r0  sed -i -e "s:=$OLD_LOGIN:=$NEW_LOGIN:g"

# Fin
rm -f /var/NEW_USERNAME
rm -f /home/$NEW_LOGIN/.config/autostart/oem-install.desktop
