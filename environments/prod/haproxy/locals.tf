locals {
  node_defaults = {
    haproxy = {
      tags = ["haproxy", "loadbalancer", "prod"]
      description     = "PROD HAProxy VM managed by Terraform"
      clone = {
        vm_id = 8100
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 2048
        floating  = 1024
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 60
        }
      ]

      network_device = {
        bridge      = "vmbr0"
        mac_address = "BC:24:11:D1:28:DC"
      }

      additional_network_devices = [
        {
          bridge      = "vmbr1"
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
    "prod-haproxy1" = { type = "haproxy", vm_id = 115, ip = "172.16.2.115/24" }
    "prod-haproxy2" = { type = "haproxy", vm_id = 116, ip = "172.16.2.116/24" }
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

  haproxy_nodes = [for name, config in local.node_configs : config if contains(config.tags, "haproxy")]
}
