locals {
  node_defaults = {
    master = {
      tags = ["master", "jenkins", "dev"]
      clone = {
        vm_id = 8150
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 8192
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 120
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
      password    = "alma"
      username    = "alma"
    }
  }

  nodes = {
    "jenkins-master" = { type = "master", vm_id = 111, ip = "172.16.3.111/24" }
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

  master_nodes = [for name, config in local.node_configs : config if contains(config.tags, "master")]
}
