# Installation Windows 10 dans une Machine Virtuelle (VM)


## Télécharger l'image iso de Windows 10 :

[https://www.microsoft.com/fr-fr/software-download/windows10ISO](https://www.microsoft.com/fr-fr/software-download/windows10ISO) 

### Préparation image spécifique Windows :
Mettre au même emplacement le répertoire :
**UA_Personnels/IUT/Commun/SERV_INF/Logiciels/Maj_W10**

	cd Maj_W10
	sh geniso_w10_2kvm.sh

## Affichage de la licence Windows inclus dans le Bios

	sudo tail -c +56 /sys/firmware/acpi/tables/MSDM

Cette licence vous servira à activer votre Windows dans la VM

## Faire l'installation dans une VM (virt-manager)


([https://linux.goffinet.org/administration/virtualisation-linux/virtualisation-kvm/](https://linux.goffinet.org/administration/virtualisation-linux/virtualisation-kvm/) )

 ( [https://blog.tremplin.ens-lyon.fr/GerardVidal/qemuKVM-Win10.html](https://blog.tremplin.ens-lyon.fr/GerardVidal/qemuKVM-Win10.html) )

([https://blog.separatewavelengths.com/2018/11/04/installing-windows-10-in-qemu-with-kvm/](https://blog.separatewavelengths.com/2018/11/04/installing-windows-10-in-qemu-with-kvm/) )

([https://getlabsdone.com/10-easy-steps-to-install-windows-10-on-linux-kvm/](https://getlabsdone.com/10-easy-steps-to-install-windows-10-on-linux-kvm/) )

**ansible/playbooks_deb11/KVM_W10.yml**

	ansible-playbook --vault-password-file ~/.authport -i hosts/I-PORT_hosts_deb madeb11/KVM_W10.yml -l 'IPEBIO-LAURE'

### Installation virt-manager

**ansible/madeb11/tasks/kvm.yml** (KVM_W10.yml)  

OU

	sudo apt install virt-manager
	
Vous pouvez vérifier si la virtualisation est possible possible :

	virt-host-validate

Ajouter votre nom d'utilisateur aux groupex libvirt et kvm :

	sudo adduser VotreNomUser libvirt
	sudo adduser VotreNomUser kvm

Pour faciliter les commandes, ajouter la variables d'environnement :

	echo LIBVIRT_DEFAULT_URI=”qemu:///system” | sudo tee -a /etc/environment
	echo export LIBVIRT_DEFAULT_URI=”qemu:///system” | sudo tee /etc/profile.d/libvirt_uri.sh
	

Si le /home est séparé créer un emplacement pour les VMs :

	sudo mkdir -p /home/KVM
	sudo chgrp kvm /home/KVM
	sudo chmod g+s /home/KVM
	cd /home/KVM
	
virtio :

	wget "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"
	
###Mettre aussi à cet emplacement les images iso pour l'installation de Windows

**ansible/playbooks_deb11/tasks/kvm_w10.yml**  (KVM_W10.yml)  

**OU**

	smbget -n "smb://172.19.75.206/logiciels/Maj_W10/ansible_autounattend.iso"
	smbget -n "smb://172.19.75.206/logiciels/ISO/Win10_21H2_French_x64.iso"


### Création automatique de la machine I-COURS : 

Récupérer les playbooks pour windows :

	cd /tmp
	smbget -n "smb://172.19.75.206/logiciels/ansible/playbooks.tar.gz"
	sudo tar -xzf /tmp/playbooks.tar.gz -C /opt/ansible/

Ajout collection windows pour ansible :

	ansible-galaxy collection install ansible.windows -p /usr/share/ansible/collections/

Création de la machine :

	cp /opt/ansible/madeb11/files/kvm/kvm_w10.sh .
	
	sudo bash kvm_w10.sh I-COURS

### Création manuelle

Lors de l'installation de windows, charger le pilote pour le disque qui se trouve sur le lecteur CD **virtio-win**

	E:\amd64\w10

#### Installer les pilotes manquants

Gestionnaire de périphériques :

Mise à jour Réseau : **E:\NetKVM\w10**

Mise à jour Pci : **E:**


Installer l'agent : **E:\guest-agent\qemu-ga-x64.msi**
Mise à jour Carte graphique : **E:**


Vous pouvez exporter la description de la machine :

	virsh dumpxml RDPWindows > RDPWindows.xml
	
### Fin installation	

Une fois la machine Windows10 totalement opérationnelle, vous pouvez ajouter les logiciels que vous souhaitez.

Si votre machine Windows s'appelle RDPWindows vous pourrez tester **WinApps for Linux** ( [https://github.com/Fmstrat/winapps](https://github.com/Fmstrat/winapps) ) pour intégrer vos applications Windows dans votre Linux.**