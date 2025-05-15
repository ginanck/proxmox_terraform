locals {
  # ipa-specific base configuration
  ipa_base = {
    description = "freeipa cluster"
    tags        = concat(local.common_config.tags, ["freeipa"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8150
    }

    cpu         = { cores = 4 }
    memory      = { dedicated = 8192, floating = 1024 }
    disk        = { size = 20 }
    additional_disks = [
      { size = 100, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual ipa-nodes with just the unique properties
  ipa_nodes = {
    "ipa-node-01" = { name = "172.16.2.25-ipa-01", vm_id = 225, ip_address = "172.16.2.25/23" }
    "ipa-node-02" = { name = "172.16.3.26-ipa-02", vm_id = 226, ip_address = "172.16.3.26/23" }
    "ipa-node-03" = { name = "172.16.3.27-ipa-03", vm_id = 227, ip_address = "172.16.3.27/23" }
  }

  # Assemble the complete freeipa configuration
  ipa_cluster = {
    for key, node in local.ipa_nodes : key => {
      name            = node.name
      vm_id           = node.vm_id
      description     = local.ipa_base.description
      tags            = local.ipa_base.tags
      clone           = local.ipa_base.clone
      cpu             = local.ipa_base.cpu
      memory          = local.ipa_base.memory
      disk            = local.ipa_base.disk
      network_device  = local.ipa_base.network_device
      
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