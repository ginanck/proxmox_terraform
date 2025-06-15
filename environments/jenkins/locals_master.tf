locals {
  # Master-specific base configuration
  master_base = {
    description = "master for jenkins"
    tags        = concat(local.common_config.tags, ["master"])

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

  # Define the individual master nodes with just the unique properties
  master_nodes = {
    "jenkins-master" = { name = "172-16-2-41-jenkins-master", vm_id = 241, ip_address = "172.16.2.41/23" }
  }

  # Assemble the complete jenkins_master configuration
  jenkins_master = {
    for key, node in local.master_nodes : key => {
      name            = node.name
      vm_id           = node.vm_id
      description     = local.master_base.description
      tags            = local.master_base.tags
      clone           = local.master_base.clone
      cpu             = local.master_base.cpu
      memory          = local.master_base.memory
      disk            = local.master_base.disk
      additional_disks = local.master_base.additional_disks
      network_device  = local.master_base.network_device

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