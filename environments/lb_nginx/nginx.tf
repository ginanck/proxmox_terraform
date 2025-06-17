locals {
  lb_nginx_config = {
    name        = "157-180-50-18-lb-nginx"
    description = "Nginx for experimentation"
    vm_id       = 411

    tags        = local.common_config.tags
    clone       = local.common_config.clone
    cpu         = local.common_config.cpu
    memory      = local.common_config.memory
    disk        = local.common_config.disk

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

      additional_ip_configs = [
        {
          ipv4 = {
            address = "172.16.2.53/23"
            gateway = ""
          }
        }
      ]

      user_account = local.common_config.user_account
    }
  }
}

locals {
  lb_webserver_config = {
    name        = "172-16-2-212-lb-nginx-webserver"
    description = "Webserver for experimentation"
    vm_id       = 412

    tags        = local.common_config.tags
    clone       = local.common_config.clone
    cpu         = local.common_config.cpu
    memory      = local.common_config.memory
    disk        = local.common_config.disk

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
          address = "172.16.2.212/23"
          gateway = "172.16.2.1"
        }
      }

      user_account = local.common_config.user_account
    }
  }
}
