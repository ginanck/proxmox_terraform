locals {
  vms = {
    nfs_server = {
      vm_id            = 261
      name             = "172-16-2-61-nfs-server"
      ip_address       = "172.16.2.61/23"
      description      = "NFS Server for K8S Storage"
      tags             = ["dev", "storage", "nfs"]
      cpu_cores        = 2
      memory_dedicated = 4096
      disk_size        = 20
      disk_additional = [
        { size = 200, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
  }
}
