locals {
  nfs_server_config = {
    name        = "172.16.2.61-nfs-server"
    description = "NFS Server for K8S Storage"
    vm_id       = 261
    tags        = concat(local.common_config.tags, ["nfs"])

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
          address = local.common_config.ipv4_addr
          gateway = local.common_config.gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }
}