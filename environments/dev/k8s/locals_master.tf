locals {
  # Master-specific base configuration
  master_base = {
    description = "master for K8S"
    tags        = concat(local.common_config.tags, ["master"])
    cpu         = { cores = 2 }
    memory      = { dedicated = 2048, floating = 1024 }
    disk        = { size = 60 }
  }

  # Define the individual master nodes with just the unique properties
  master_nodes = {
    "k8s-master01" = { name = "master01", vm_id = 225, ip_address = "172.16.3.225/23" }
    "k8s-master02" = { name = "master02", vm_id = 226, ip_address = "172.16.3.226/23" }
    "k8s-master03" = { name = "master03", vm_id = 227, ip_address = "172.16.3.227/23" }
  }

  # Assemble the complete k8s_master configuration
  k8s_master = {
    for key, node in local.master_nodes : key => {
      name        = node.name
      description = local.master_base.description
      vm_id       = node.vm_id
      tags        = local.master_base.tags
      cpu         = local.master_base.cpu
      memory      = local.master_base.memory
      disk        = local.master_base.disk
      
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