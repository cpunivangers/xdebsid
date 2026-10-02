#!/bin/sh

# Allows you to use both VirtualBox and KVM virtualization on the same machine.
# I replaced the commands to start both VB and KVM with this script.

# you'll also need to disable both services from starting automatically.
# sudo update-rc.d qemu-kvm disable
# sudo update-rc.d vboxdrv disable

case "$1" in
    vbox)
        gksudo service qemu-kvm stop
        gksudo service vboxdrv start
        VirtualBox
    ;;
    *)
        gksudo service vboxdrv stop
        gksudo service qemu-kvm start
        virt-manager
    ;;
esac