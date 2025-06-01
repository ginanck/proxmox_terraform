locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "65.109.108.152/26"
      vmbr1_mac     = "00:50:56:01:21:F3"
      vmbr1_gateway = "65.109.108.129"
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

  posteio_config = {
    name        = "65.109.108.152-posteio"
    description = "Poste.io Dockerized Email Server"
    vm_id       = 102
    tags        = concat(local.common_config.tags, ["posteio"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8150
    }

    cpu = {
      cores      = 4
    }

    memory = {
      dedicated      = 4096
      floating       = 1024
    }

    disk = {
      size = 20
    }

    additional_disks = [
      { size = 100, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr0"
      model    = "virtio"
    }

    initialization = {
      dns = {
        servers = local.common_config.dns_servers
      }
      ip_config = {
        ipv4 = {
          address     = local.common_config.interfaces.vmbr1_ip
          mac_address = local.common_config.interfaces.vmbr1_mac
          gateway     = local.common_config.interfaces.vmbr1_gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }
}
