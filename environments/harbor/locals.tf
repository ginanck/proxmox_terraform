locals {
  vms = {
    harbor = {
      vm_id            = 235
      name             = "172-16-2-35-harbor"
      ip_address       = "172.16.2.35/23"
      description      = "Harbor for Docker Registry"
      tags             = ["dev", "harbor", "registry"]
      cpu_cores        = 4
      memory_dedicated = 8192
      disk_size        = 20
      disk_additional = [
        { size = 200, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
  }
}
