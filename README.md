# terraform-deploy-vms

![alt text](https://img.shields.io/badge/proxmox-6.0--4-brightgreen) ![alt text](https://img.shields.io/badge/terraform-v0.12.25-brightgreen) ![alt text](https://img.shields.io/badge/openstack-debian--10--openstack--amd64-brightgreen)
#

## Introduction
Set de scripts permettant de déployer rapidement des VMs sur Proxmox via Cloud-Init &amp; Terraform

![alt text](https://i.imgur.com/CBXKtD0.png)

Ceci est un ensemble de petits scripts permettant de :

▶️ Télécharger une image disque d'une Debian 10 OpenStack, puis créer une VM avec celle-ci et en faire un template 
(template-debian-1000.sh).

▶️ Cloner ce template en un nombre désiré via Terraform, en setupant une IP fixe pour chaque VM (main.tf).

▶️ Exécuter un script bash classique permettant de mettre à jour la VM créée et installer Docker (startup.sh).

## Installation

![alt text](https://i.imgur.com/MFpRlPw.png)

## Support
Ceci n'est qu'un simple essai de ma part, pour découvrir ce que sont Terraform & Cloud-Init, dans le but de réaliser un petit cluster Kubernetes, pour plus d'informations vous pouvez aller voir l'article correspondant sur mon blog (en cours de rédaction).

Pour ces raisons, aucun support ne sera assuré ce dépôt Github.

## Post-Scriptum
A l'heure où j'écris ces lignes le dépôt vient tout juste d'être créé, et si vous souhaitez d'ores et déjà utiliser ce set de scripts il vous faudra soit modifier le path du script startup.sh vers la fin du script main.tf, soit créer un dossier "Terraform" dans "~/Documents" et l'y déposer. Cela sera corrigé bientôt, peut être, si j'ai le temps 😅

Bien entendu, ce script n'est pas à utiliser en production, pas mal de choses seraient à modifier mais le fonctionnement est bel et bien là !



