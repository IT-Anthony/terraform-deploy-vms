#!/bin/bash
# template-debian-1000.sh
# Mairien Anthony - Notamax
# Mis à jour le 20-05-20

# Création d'une VM avec ID 1000 nommée debian-10-template, 2Go RAM, 1 proco, 2 coeurs
qm create 1000 -name debian-10-template -memory 2048 -net0 virtio,bridge=vmbr0 -cores 2 -sockets 1 -cpu cputype=kvm64 -kvm 1 -numa 1
# Import du disque
qm importdisk 1000 debian-10-openstack-amd64.qcow2 local-lvm
# Attachement du disque à la VM
qm set 1000 -scsihw virtio-scsi-pci -virtio0 local-lvm:vm-1000-disk-0
# Ajout lecteur CD pour cloudinit
qm set 1000 -ide2 local-lvm:cloudinit
qm set 1000 -serial0 socket
# Boot sur disque principal
qm set 1000 -boot c -bootdisk virtio0
qm set 1000 -agent 1
qm set 1000 -hotplug disk,network,usb,memory,cpu
# 2 cores x1 sockets = 2 Vcpus
qm set 1000 -vcpus 2
qm set 1000 -vga qxl
# Copie clé SSH publique de l'hôte proxmox-01
qm set 1000 --sshkey ~/.ssh/id_rsa.pub
# Passage en template
qm template 1000
# Passage taille du disque à 20Go et non plus 2Go
qm resize 1000 virtio0 +18G