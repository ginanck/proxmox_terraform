locals {
  node_defaults = {
    haproxy = {
      tags = ["haproxy", "loadbalancer", "prod"]
      description     = "PROD HAProxy VM managed by Terraform"
      clone = {
        vm_id = 8100
      }

      cpu = {
        cores = 2
      }

      memory = {
        dedicated = 2048
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 40
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
      password    = "rocky"
      username    = "rocky"
    }
  }

  nodes = {
    "k8s-prod-haproxy1" = { type = "haproxy", vm_id = 130, ip = "172.16.2.130/24" }
    "k8s-prod-haproxy2" = { type = "haproxy", vm_id = 131, ip = "172.16.2.131/24" }
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
