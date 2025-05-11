terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.77.1"
    }
  }
}

provider "proxmox" {
  insecure = true
}
