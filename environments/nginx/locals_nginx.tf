locals {
  nginx_config = {
    name        = "nginx01"
    description = "Nginx for K8S LB"
    vm_id       = 281
    tags        = concat(local.common_config.tags, ["loadbalancer"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8150
    }

    cpu = {
      cores      = 2
    }
    
    memory = {
      dedicated      = 2048
      floating       = 1024
    }

    disk = {
      size = 40
    }

    network_device = {
      bridge   = "vmbr0"
      model    = "virtio"
      mac_address = local.common_config.interfaces.vmbr0_mac
    }

    additional_network_devices = [
      {
        bridge      = "vmbr1"
        model       = "virtio"
      }
    ]

    initialization = {
      dns = { 
        servers = local.common_config.dns_servers
      }
      ip_config = {
        ipv4 = {
          address = "dhcp"
          gateway = ""
        }
      }
      user_account = local.common_config.user_account
    }
  }
}
