locals {
  vms = {
    lb_nginx = {
      vm_id            = 411
      name             = "157-180-50-18-lb-nginx"
      ip_address       = "dhcp"
      description      = "Nginx for experimentation"
      tags             = ["experiment", "loadbalancer", "nginx"]
      cpu_cores        = 2
      memory_dedicated = 4096
      disk_size        = 40
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      network_mac_address = "00:50:56:01:17:1D"
      additional_ip_configs = [
        {
          address = "172.16.2.53/23"
          gateway = null
        }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
  }
}
