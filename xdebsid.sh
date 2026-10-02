#!/bin/bash
 
# 12/03/2026
# christian.pottier@univ-angers.fr
#  
# maj xdebsid

if [ -z $BASH ]; then
	echo "Lancer avec bash !"
	exit
fi
if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "sudo $0 ou sudo -i"
	exit 1
fi

source /opt/ansible/vansible/bin/activate
cd /opt/ansible/xdebsid
echo "debut $(date) xdebsid" | sudo tee preseed.log
# playbook de base xdebsid
ansible-playbook -i localhost, -c local -e 'ansible_host=127.0.0.1 mac=00:00:00:00:00:00' playbooks/xdebsid.yml
echo "fin $(date) xdebsid"| sudo tee -a preseed.log
deactivate
