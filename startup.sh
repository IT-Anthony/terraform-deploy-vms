#!/bin/bash
# startup.sh
# Mairien Anthony - Notamax
# Mis à jour le 20-05-20
# Les "sleep" sont obligatoires sinon délais trop courts et plantage

# Mise à jour des dépôts & paquets
sleep 30 && sudo apt-get update && sleep 10 && sudo apt-get upgrade -y && sleep 30 && sudo apt-get dist-upgrade -y && sleep 30

# Installation dépendances pour Docker
sudo apt -y install software-properties-common apt-transport-https ca-certificates curl gnupg2 software-properties-common && sleep 30

# Ajout du dépôt Docker et de la clé 
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
   
# Ajout du dépôt Kubernetes et de la clé puis installation de kubelet/kube-adm/kubenetes-cni
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubernetes-cni

# Seconde mise à jour des dépôts & installation Docker + paquets de base + démarrage docker au boot
sleep 20 && sudo apt-get update && sleep 10 && sudo apt -y install docker-ce docker-ce-cli htop vim qemu-guest-agent && sudo systemctl enable docker && sudo systemctl start docker
