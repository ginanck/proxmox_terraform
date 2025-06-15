locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "172.16.2.21/23"
      vmbr1_gateway = "172.16.2.1"
    }
    dns_servers = ["8.8.8.8", "8.8.4.4"]
    user_account = {
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz"
      ]
      username = "ansible"
      password = "ansible"
    }
    tags = ["dev"]
  }

  technitium_config = {
    name        = "172-16-2-21-technitium"
    description = "technitium dns server for lab setup"
    vm_id       = 221
    tags        = concat(local.common_config.tags, ["technitium"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8053
    }

    cpu = {
      cores      = 2
    }

    memory = {
      dedicated = 2048
    }

    disk = {
      size = 12
    }

    additional_disks = [
      { size = 20, interface = "virtio1" }
    ]

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
