terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.77.1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.4"
    }
  }
}

provider "proxmox" {
  insecure = true
}
