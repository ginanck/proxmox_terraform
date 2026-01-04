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
    win2012r2 = {
      clone_vm_id      = 7951
      vm_id            = 2803
      name             = "172-16-3-223-win2012r2"
      ip_address       = "172.16.3.223/23"
      description      = "win2012r2"
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
    win2016 = {
      clone_vm_id      = 7952
      vm_id            = 2804
      name             = "172-16-3-224-win2016"
      ip_address       = "172.16.3.224/23"
      description      = "win2016"
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
    win2019 = {
      clone_vm_id      = 7953
      vm_id            = 2805
      name             = "172-16-3-225-win2019"
      ip_address       = "172.16.3.225/23"
      description      = "win2019"
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
    win2022 = {
      clone_vm_id      = 7954
      vm_id            = 2806
      name             = "172-16-3-226-win2022"
      ip_address       = "172.16.3.226/23"
      description      = "win2022"
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
