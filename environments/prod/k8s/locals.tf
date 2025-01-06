locals {
  node_defaults = {
    master = {
      tags = ["master", "k8s", "prod"]
      description     = "PROD K8S Master VM managed by Terraform"
      clone = {
        vm_id = 8052
      }

      cpu = {
        cores = 2
      }

      memory = {
        dedicated = 4096
        floating  = 1024
      }

      disk = {
        size = 20
      }

      additional_disks = [
        {
          interface   = "virtio1"
          size        = 80
        }
      ]
    }

    worker = {
      tags = ["worker", "k8s", "prod"]
      description     = "PROD K8S Worker VM managed by Terraform"
      clone = {
        vm_id = 8052
      }

      cpu = {
        cores = 4
      }

      memory = {
        dedicated = 8192
        floating  = 2048
      }

      disk = {
        size = 20
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
      password    = "ubuntu"
      username    = "ubuntu"
    }
  }

  nodes = {
    "k8s-prod-master1" = { type = "master", vm_id = 121, ip = "172.16.2.121/24" }
    "k8s-prod-master2" = { type = "master", vm_id = 122, ip = "172.16.2.122/24" }
    "k8s-prod-master3" = { type = "master", vm_id = 123, ip = "172.16.2.123/24" }
    "k8s-prod-worker1" = { type = "worker", vm_id = 125, ip = "172.16.2.125/24" }
    "k8s-prod-worker2" = { type = "worker", vm_id = 126, ip = "172.16.2.126/24" }
    "k8s-prod-worker3" = { type = "worker", vm_id = 127, ip = "172.16.2.127/24" }
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
