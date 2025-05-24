locals {
  # Master-specific base configuration
  master_base = {
    description = "master for K8S"
    tags        = concat(local.common_config.tags, ["master"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8101
    }

    cpu         = { cores = 2 }
    memory      = { dedicated = 4096, floating = 2048 }
    disk        = { size = 40 }
    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual master nodes with just the unique properties
  master_nodes = {
    "k8s-master01" = { name = "172.16.3.101-master-01", vm_id = 301, ip_address = "172.16.3.101/23" }
    "k8s-master02" = { name = "172.16.3.102-master-02", vm_id = 302, ip_address = "172.16.3.102/23" }
    "k8s-master03" = { name = "172.16.3.103-master-03", vm_id = 303, ip_address = "172.16.3.103/23" }
  }

  # Assemble the complete k8s_master configuration
  k8s_master = {
    for key, node in local.master_nodes : key => {
      name            = node.name
      vm_id           = node.vm_id
      description     = local.master_base.description
      tags            = local.master_base.tags
      clone           = local.master_base.clone
      cpu             = local.master_base.cpu
      memory          = local.master_base.memory
      disk            = local.master_base.disk
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