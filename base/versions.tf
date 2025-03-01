terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
      configuration_aliases = [proxmox]
    }
  }
}
