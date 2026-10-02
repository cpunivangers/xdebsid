#!/bin/bash
# Creation VM XP

VM_NAME="XP"
VM_PATH="/home/DATA/KVM"

virsh destroy $VM_NAME
virsh undefine $VM_NAME --storage $VM_PATH/$VM_NAME.qcow2

qemu-img create -f qcow2 $VM_PATH/$VM_NAME.qcow2 20G

virsh net-autostart default

virt-install \
    --name=$VM_NAME \
    --ram=2048 \
    --cpu=host \
    --vcpus=2 \
    --os-type=windows \
    --os-variant=winxp \
    --disk path=$VM_PATH/$VM_NAME.qcow2,format=qcow2,bus=virtio \
    --disk $VM_PATH/winXP_SP3.iso,device=cdrom,bus=sata \
    --disk $VM_PATH/virtio-win.iso,device=cdrom,bus=sata \
    --network network=default,model=virtio \
    --graphics vnc,listen=0.0.0.0 \
    --sound \
    --boot cdrom
