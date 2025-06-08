locals {
  # slave-specific base configuration
  slave_base = {
    description = "slave for jenkins"
    tags        = concat(local.common_config.tags, ["slave"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8150
    }

    cpu         = { cores = 4 }
    memory      = { dedicated = 8192 }

    disk = {
      size = 20
    }

    additional_disks = [
      { size = 100, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual slave nodes
  slave_nodes = {
    "jenkins-slave01" = { name = "172.16.2.42-jenkins-slave-01", vm_id = 242, ip_address = "172.16.2.42/23" }
  }

  # Assemble the complete jenkins_slave configuration
  jenkins_slaves = {
    for key, node in local.slave_nodes : key => {
      name             = node.name
      vm_id            = node.vm_id
      description      = local.slave_base.description
      tags             = local.slave_base.tags
      clone            = local.slave_base.clone
      cpu              = local.slave_base.cpu
      memory           = local.slave_base.memory
      disk             = local.slave_base.disk
      additional_disks = local.slave_base.additional_disks
      network_device   = local.slave_base.network_device

      initialization = {
        dns = {
          servers = local.common_config.dns_servers
        }
        ip_config = {
          ipv4 = {
            address = node.ip_address
            gateway = local.common_config.gateway
          }
        }
        user_account = local.common_config.user_account
      }
    }
  }
}