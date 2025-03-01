locals {
  nfs_config = {
    name        = "nfs"
    description = "nfs for K8S storage"
    vm_id       = 220
    tags        = ["dev", "k8s", "nfs"]
    cpu         = { cores = 4 }
    memory      = { dedicated = 4096, floating = 2048 }
    disk        = { size = 20 }
    additional_disks = [
      { size = 140, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }

    initialization = {
      dns = {
        servers = ["8.8.8.8", "8.8.4.4"]
      }
      ip_config = {
        ipv4 = {
          address = "172.16.3.220/23"
          gateway = local.common_config.gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }
}