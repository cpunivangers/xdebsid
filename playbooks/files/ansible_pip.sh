#!/bin/bash

# Installation ansible dans envirennement python 
# 03/04/2023
# christian.pottier@univ-angers.fr
#
if [ -z $BASH ]; then
	echo "Lancer avec bash !"
	exit
fi

# Maj Debian
sudo apt update -y --allow-releaseinfo-change
sudo apt full-upgrade -y

## Environnement ansible pip
# Vérif ansible installé
if ! ( sudo apt-cache policy ansible | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y remove ansible
fi

# Vérif environnement ansible pip installé
## Création environnement virtuel python
if ( sudo apt-cache policy python3-venv | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y install python3-venv
fi
sudo mkdir -m 2755 -p /opt/ansible
sudo chown -R $USER:sudo /opt/ansible
python3 -m venv /opt/ansible/vansible

## Activation environnement
source /opt/ansible/vansible/bin/activate
## Mise à jour pip sous l'environnement python
python3 -m pip install --upgrade pip
## Installation ansible
python3 -m pip install --upgrade ansible
ansible --version
## Ajout pour machine windows
python3 -m pip install --upgrade pywinrm
sudo mkdir -m 2755 -p /usr/share/ansible/collections
sudo chown -R $USER:sudo /usr/share/ansible/collections
ansible-galaxy collection install ansible.windows -p /usr/share/ansible/collections/
## fin
deactivate

# création de l'alias
FILE_ALIAS="$HOME/.bashrc"
if ( grep -qxF 'if [ -f ~/.bash_aliases ]; then' $FILE_ALIAS ) ; then
	FILE_ALIAS="$HOME/.bash_aliases"
fi
echo $FILE_ALIAS
if ! ( grep -q "alias vansible=" $FILE_ALIAS ) ; then
	echo "alias vansible='source /opt/ansible/vansible/bin/activate'" | tee -a $FILE_ALIAS
fi

# ansible log
sudo mkdir -m 2755 -p /var/log/ansible
sudo chown -R $USER:sudo /var/log/ansible

## Outils pour nos playbooks
sudo apt install -y bash-completion curl dos2unix tofrodos unzip html-xml-utils sshpass rsync

#read -p "$HOME Press any key to resume ..."
