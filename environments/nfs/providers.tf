terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.73.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

provider "proxmox" {
  insecure = true
}
