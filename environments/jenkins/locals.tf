locals {
  vms = {
    master = {
      clone_vm_id      = 8150
      vm_id            = 241
      name             = "172-16-2-41-jenkins-master"
      ip_address       = "172.16.2.41/23"
      description      = "Master for Jenkins"
      tags             = ["dev", "jenkins", "master"]
      cpu_cores        = 4
      memory_dedicated = 8192
      disk_size        = 20
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
    slave01 = {
      vm_id            = 242
      name             = "172-16-2-42-jenkins-slave-01"
      ip_address       = "172.16.2.42/23"
      description      = "Slave for Jenkins"
      tags             = ["dev", "jenkins", "slave"]
      cpu_cores        = 4
      memory_dedicated = 4096
      disk_size        = 20
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
    slave02 = {
      vm_id            = 243
      name             = "172-16-2-43-jenkins-slave-02"
      ip_address       = "172.16.2.43/23"
      description      = "Slave for Jenkins"
      tags             = ["dev", "jenkins", "slave"]
      cpu_cores        = 4
      memory_dedicated = 4096
      disk_size        = 20
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
    }
  }
}
