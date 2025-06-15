locals {
  nginx_config = {
    name        = "172-16-2-81-nginx"
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
      dedicated      = 4096
    }

    disk = {
      size = 40
    }

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }

    initialization = {
      dns = { 
        servers = local.common_config.dns_servers
      }
      ip_config = {
        ipv4 = {
          address = local.common_config.interfaces.vmbr1_ip
          gateway = local.common_config.interfaces.vmbr1_gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }
}
