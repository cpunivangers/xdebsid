# KVM

[https://blog.tremplin.ens-lyon.fr/GerardVidal/qemuKVM-Win10.html](https://blog.tremplin.ens-lyon.fr/GerardVidal/qemuKVM-Win10.html) 

sudo swupd bundle-add kvm-host \
&& for group in kvm libvirt; do sudo usermod -G ${group} -a $USER; done \
&& sudo mkdir -p /etc/profile.d/ \
&& echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' | sudo tee /etc/profile.d/libvirt.conf \
&& sudo systemctl enable libvirtd --now \
&& reboot