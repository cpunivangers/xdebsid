#!/bin/bash
 
# 23/09/2025
# christian.pottier@univ-angers.fr
#
if [ -z $BASH ]; then
	echo "Lancer avec bash !"
	exit
fi

sudo pkill xfconfd

sudo rm -rd ~/.cache/sessions
sudo rm -rf ~/.config/xfce4
sudo rm -rf ~/.config/xfce4.tar
sudo rm -rf /etc/skel/.config/xfce4.tar

# Téléchargement ansible madeb
curl -sL https://raw.githubusercontent.com/cpunivangers/madeb13/main/playbooks/files/update_madeb13.sh > /tmp/update_madeb13.sh
bash /tmp/update_madeb13.sh download

source /opt/ansible/vansible/bin/activate
cd /opt/ansible/madeb13
echo "debut $(date) mini_deb13" | sudo tee mini_deb13.log
# playbook mini deb
ansible-playbook playbooks/tplinux.yml -i localhost, -c local
echo "fin $(date) mini_deb13"| sudo tee -a mini_deb13.log
deactivate
