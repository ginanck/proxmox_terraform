locals {
  server_instance = "143"
  selected_interface = local.server_instance == "143" ? local.common_config.interfaces_143 : local.common_config.interfaces_152
  selected_ip = split("/", local.selected_interface.vmbr0_ip)[0]

  common_config = {
    dns_servers = ["8.8.8.8", "8.8.4.4"]

    interfaces = {
      vmbr0_gateway = "65.109.108.129"
    }

    interfaces_143 = {
      vmbr0_mac     = "00:50:56:01:23:9C"
      vmbr0_ip      = "65.109.108.143/26"
    }

    interfaces_152 = {
      vmbr0_mac     = "00:50:56:01:21:F3"
      vmbr0_ip      = "65.109.108.152/26"
    }

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
    name        = "${local.selected_ip}-posteio"
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
      mac_address = local.selected_interface.vmbr0_mac
    }

    initialization = {
      dns = {
        servers = local.common_config.dns_servers
      }
      ip_config = {
        ipv4 = {
          address     = local.selected_interface.vmbr0_ip
          gateway     = local.common_config.interfaces.vmbr0_gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }
}
