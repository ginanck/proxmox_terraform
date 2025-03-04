locals {
  # pve--specific base configuration
  pve_base = {
    description = "proxmox cluster"
    tags        = concat(local.common_config.tags, ["proxmox"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8002
    }

    cpu         = { cores = 4 }
    memory      = { dedicated = 8192, floating = 1024 }
    disk        = { size = 40 }
    additional_disks = [
      { size = 120, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual pve- nodes with just the unique properties
  pve_nodes = {
    "pve-node-01" = { name = "pve-01", vm_id = 251, ip_address = "172.16.3.51/23" }
    "pve-node-02" = { name = "pve-02", vm_id = 252, ip_address = "172.16.3.52/23" }
    "pve-node-03" = { name = "pve-03", vm_id = 253, ip_address = "172.16.3.53/23" }
  }

  # Assemble the complete k8s_pve- configuration
  pve_cluster = {
    for key, node in local.pve_nodes : key => {
      name            = node.name
      vm_id           = node.vm_id
      description     = local.pve_base.description
      tags            = local.pve_base.tags
      clone           = local.pve_base.clone
      cpu             = local.pve_base.cpu
      memory          = local.pve_base.memory
      disk            = local.pve_base.disk
      network_device  = local.pve_base.network_device
      
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