# KVM

test **kvm** possible :

	sudo apt install cpu-checker
	sudo kvm-ok

[https://github.com/Fmstrat/winapps/blob/main/docs/KVM.md](https://github.com/Fmstrat/winapps/blob/main/docs/KVM.md) 


Liste des machines du system :

	virsh --connect qemu:///system list --all

Infos réseau machine :

	virsh --connect qemu:///system net-dhcp-leases default | grep RDPWindows

Mac :

	virsh --connect qemu:///system net-dhcp-leases default | grep RDPWindows | awk '{print $3}'

IP:

	virsh --connect qemu:///system net-dhcp-leases default | grep RDPWindows | awk '{print $5}'


