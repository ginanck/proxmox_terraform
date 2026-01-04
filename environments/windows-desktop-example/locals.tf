locals {
  vms = {
    win10 = {
      clone_vm_id      = 7901
      vm_id            = 2801
      name             = "172-16-3-221-win10"
      ip_address       = "172.16.3.221/23"
      description      = "win10"
      tags             = ["windows"]
      bios             = "ovmf"
      cpu_cores        = 4
      cpu_type         = "host"
      memory_dedicated = 8192
      disk_size        = 100
      disk_interface   = "sata0"
      disk_additional = [
        { size = 200, interface = "sata1" }
      ]
      init_username    = var.init_username
      init_password    = var.init_password
      init_dns_servers = ["172.16.2.1"]
      is_windows       = true
      force_update     = false
    }
    win11 = {
      clone_vm_id      = 7902
      vm_id            = 2802
      name             = "172-16-3-222-win11"
      ip_address       = "172.16.3.222/23"
      description      = "win11"
      tags             = ["windows"]
      bios             = "ovmf"
      cpu_cores        = 4
      cpu_type         = "host"
      memory_dedicated = 8192
      disk_size        = 100
      disk_interface   = "sata0"
      disk_additional = [
        { size = 200, interface = "sata1" }
      ]
      init_username    = var.init_username
      init_password    = var.init_password
      init_dns_servers = ["172.16.2.1"]
      is_windows       = true
      force_update     = false
    }
  }
}
