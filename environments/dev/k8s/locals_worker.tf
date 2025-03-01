locals {
  # Worker-specific base configuration
  worker_base = {
    description = "worker for K8S"
    tags        = concat(local.common_config.tags, ["worker"])
    cpu         = { cores = 4 }
    memory      = { dedicated = 4096, floating = 2048 }
    disk        = { size = 40 }
    additional_disks = [
      { size = 120, interface = "virtio1" }
    ]
    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual worker nodes
  worker_nodes = {
    "k8s-worker01" = { name = "worker01", vm_id = 231, ip_address = "172.16.3.231/23" }
    "k8s-worker02" = { name = "worker02", vm_id = 232, ip_address = "172.16.3.232/23" }
    "k8s-worker03" = { name = "worker03", vm_id = 233, ip_address = "172.16.3.233/23" }
  }

  # Assemble the complete k8s_worker configuration
  k8s_worker = {
    for key, node in local.worker_nodes : key => {
      name        = node.name
      description = local.worker_base.description
      vm_id       = node.vm_id
      tags        = local.worker_base.tags
      cpu         = local.worker_base.cpu
      memory      = local.worker_base.memory
      disk        = local.worker_base.disk
      additional_disks           = local.worker_base.additional_disks
      network_device             = local.worker_base.network_device

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