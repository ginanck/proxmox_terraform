locals {
  node_defaults = {
    master = {
      tags = ["master", "k8s", "dev"]
      clone = {
        vm_id = 8052
      }

      cpu = {
        cores = 2
      }

      memory = {
        dedicated = 2048
      }

      disk = {
        size = 20
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 40
        }
      ]
    }

    worker = {
      tags = ["worker", "k8s", "dev"]
      clone = {
        vm_id = 8053
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 2048
      }

      disk = {
        size = 20
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 60
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
      password    = "ubuntu"
      username    = "ubuntu"
    }
  }

  nodes = {
    "k8s-dev-master1" = { type = "master", vm_id = 691, ip = "172.16.3.191/24" }
    "k8s-dev-worker1" = { type = "worker", vm_id = 692, ip = "172.16.3.192/24" }
    "k8s-dev-worker2" = { type = "worker", vm_id = 693, ip = "172.16.3.193/24" }
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
  worker_nodes = [for name, config in local.node_configs : config if contains(config.tags, "worker")]
}
