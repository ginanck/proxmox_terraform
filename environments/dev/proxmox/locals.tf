locals {
  node_defaults = {
    proxmox = {
      tags = ["proxmox", "cluster"]
      description     = "Proxmox Cluster VM managed by Terraform"
      clone = {
        vm_id = 8002
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 8192
        floating  = 1024
      }

      disk = {
        size = 40
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 100
        }
      ]
    }
  }

  base_initialization = {
    dns = {
      servers = ["8.8.8.8", "8.8.4.4"]
    }

    ip_config = {
      ipv4 = {
        gateway = "172.16.2.1"
      }
    }

    user_account = {
      password    = "ansible"
      username    = "ansible"
    }
  }

  nodes = {
    "proxmox-dev-cluster1" = { type = "proxmox", vm_id = 301, ip = "172.16.3.241/23" }
    "proxmox-dev-cluster2" = { type = "proxmox", vm_id = 302, ip = "172.16.3.242/23" }
    "proxmox-dev-cluster3" = { type = "proxmox", vm_id = 303, ip = "172.16.3.243/23" }
  }

  node_configs = {
    for name, node in local.nodes : name => merge(
      local.node_defaults[node.type],
      {
        name = name
        vm_id = node.vm_id
        initialization = merge(local.base_initialization, { ip_config = { ipv4 = { address = node.ip } } } )
      }
    )
  }

  proxmox_nodes = [for name, config in local.node_configs : config if contains(config.tags, "proxmox")]
}
