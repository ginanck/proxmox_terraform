locals {
  node_defaults = {
    dns = {
      tags = ["dns", "technitium", "dev"]
      description     = "DEV DNS Server VM managed by Terraform"
      clone = {
        vm_id = 8151
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 1024
        floating  = 512
      }
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
    "dev-dns" = { type = "dns", vm_id = 209, ip = "172.16.3.209/23" }
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

  dns_nodes = [for name, config in local.node_configs : config if contains(config.tags, "dns")]
}
