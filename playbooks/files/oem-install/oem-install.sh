#!/bin/bash
 
# 09/2025
# christian.pottier@univ-angers.fr
# oem installation, préparation du changement de l'indentifiant principal

OLD_LOGIN=$(id -un -- 1000)
NEW_LOGIN=`yad \
	--title="Changer votre identifiant principal" \
	--width 500 \
	--text="\n\t <big><b>Vous pouvez changer votre identifiant</b></big>\n\n <i>Vous changerez ensuite votre nom complet et votre mot de passe avec\n les outils standards du système.</i>\n\n Identifiant actuel : <b>$OLD_LOGIN</b>\n\n Votre indentifiant doit contenir uniquement des lettres minuscules\n" \
	--form \
	--field=" Nouvel Identifiant :" ""`
	
# Si non validé (echap, annule)
if [ $? -ne 0 ]; then
    #On quitte le script
    exit
fi
NEW_LOGIN=$(echo "$NEW_LOGIN" | cut -d "|" -f1)
if [ -z "$NEW_LOGIN" ] ; then
	exit
fi
echo "$OLD_LOGIN => $NEW_LOGIN"
if [ "$OLD_LOGIN" = "$NEW_LOGIN" ] ; then
	rm -f /var/NEW_USERNAME
	exit 0
fi

source /etc/os-release

pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY bash /opt/ansible/madeb$VERSION_ID/playbooks/files/oem-install/pre_change_login.sh $NEW_LOGIN
