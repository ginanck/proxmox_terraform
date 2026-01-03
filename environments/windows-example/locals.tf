locals {
  vms = {
    win10 = {
      vm_id            = 2801
      name             = "172-16-3-220-Win10"
      ip_address       = "172.16.3.219/23"
      description      = "Win10"
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
