locals {
  vms = {
    nginx = {
      vm_id            = 281
      name             = "172-16-2-81-nginx"
      ip_address       = "172.16.2.81/23"
      description      = "Nginx for K8S LB"
      tags             = ["dev", "nginx", "loadbalancer"]
      cpu_cores        = 2
      memory_dedicated = 4096
      disk_size        = 40
      init_username    = var.init_username
      init_password    = var.init_password
    }
  }
}
