locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "172.16.2.31/23"
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
    tags = ["dev", "gitea"]
  }

  gitea_config = {
    name        = "172.16.2.31-gitea"
    description = "gitea for K8S LB"
    vm_id       = 231
    tags        = concat(local.common_config.tags, ["scm"])

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
      floating       = 1024
    }

    disk = {
      size = 20
    }

    additional_disks = [
      { size = 200, interface = "virtio1" }
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