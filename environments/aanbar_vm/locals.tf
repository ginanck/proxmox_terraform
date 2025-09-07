locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "172.16.3.200/23"
      vmbr1_gateway = "172.16.2.1"
    }
    dns_servers = ["8.8.8.8", "8.8.4.4"]
    user_account = {
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdlFN/9Nq77zNd4SayTN+y5j+fZWmXK1CynQU7jou3j ansible@aanbar-lab"
      ]
      username = "ansible"
      password = "ansible"
    }
    tags = ["ansible-lab"]
  }

  vm_config = {
    name        = "172-16-3-200-ansible-lab"
    description = "ansible lab"
    vm_id       = 400
    tags        = concat(local.common_config.tags, ["ansible-lab"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8053
    }

    cpu = {
      cores      = 4
    }

    memory = {
      dedicated      = 8192
    }

    disk = {
      size = 20
    }

    additional_disks = [
      { size = 100, interface = "virtio1" }
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
