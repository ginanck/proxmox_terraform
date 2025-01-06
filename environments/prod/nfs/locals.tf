locals {
  node_defaults = {
    nfs = {
      tags = ["nfs", "storage", "prod"]
      description     = "PROD NFS Server VM managed by Terraform"
      clone = {
        vm_id = 8150
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 4096
        floating  = 1024
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 150
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
    "prod-nfs" = { type = "nfs", vm_id = 113, ip = "172.16.2.113/24" }
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

  nfs_nodes = [for name, config in local.node_configs : config if contains(config.tags, "nfs")]
}
