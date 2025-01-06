terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.69.0"
    }
  }
}

provider "proxmox" {
  insecure = true
}
