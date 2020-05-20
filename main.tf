# Script permettant de déployer X VMs sur hôte Proxmox via Cloud-Init & Terraform
# Mairien Anthony - Notamax
# Mis à jour le 20-05-20
# Définition du provider (ici proxmox-01)
provider "proxmox" {
    pm_api_url = "https://proxmoxIP:8006/api2/json"
    pm_user = "root@pam"
    pm_password = "SuperPaSSw0rD"
    # Laisser à "true" si certificat auto-signé
    pm_tls_insecure = "true"
}

# Création variable pour nombre de VMs à déployer (récupéré via l'argument -var 'nombre=X')
variable "nombre" {
  type = number
}

# Définition de la VM à créer
resource "proxmox_vm_qemu" "proxmox_vm" {
  count             = var.nombre
  name              = "vm-0${count.index}"
  # Nom du node sur lequel le déploiement aura lieu
  target_node       = "pve-01"
  clone             = "debian-10-template"
  full_clone        = true
  os_type           = "cloud-init"
  cores             = 2
  sockets           = "1"
  cpu               = "host"
  memory            = 2048
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"
disk {
    id              = 0
    size            = 20
    type            = "scsi"
    storage         = "local-lvm"
    storage_type    = "lvm"
    iothread        = true
  }
network {
    id              = 0
    model           = "virtio"
    bridge          = "vmbr0"
  }

# Configuration relative à CloudInit
  # Clé SSH publique
  sshkeys =  <<EOF
  MaSuperCléSSH
  EOF

  # Setup de l'IP statique
  ipconfig0 = "ip=192.168.1.10${count.index + 1}/24,gw=192.168.1.1"
  ciuser = "it-anthony"
  cipassword = "SuperPaSSw0rD"
  
  # Déclaration du script de démarrage, en utilisant user it-anthony + clé SSH privée
  provisioner "file" {
    source      = "~/Documents/Terraform/startup.sh"
    destination = "/tmp/startup.sh"
      connection {
      type     = "ssh"
      user     = "it-anthony"
      private_key     = "${file("~/.ssh/id_rsa")}"
      host     = "${self.ssh_host}"
   }
  }
  # Exécution du script de démarrage
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/startup.sh",
      "/tmp/startup.sh",
    ]
    connection {
      type     = "ssh"
      user     = "it-anthony"
      private_key     = "${file("~/.ssh/id_rsa")}"
      host     = "${self.ssh_host}"
   }
  }
}
