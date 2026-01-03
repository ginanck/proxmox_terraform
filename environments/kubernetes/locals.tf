locals {
  vms = {
    master-02 = {
      vm_id            = 302
      name             = "172-16-3-102-master-02"
      ip_address       = "172.16.3.102/23"
      description      = "master for K8S"
      tags             = ["dev", "k8s", "master"]
      cpu_cores        = 4
      memory_dedicated = 8192
      disk_size        = 40
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      clone_vm_id   = 8101
      init_username = var.init_username
      init_password = var.init_password
    }
    worker-02 = {
      vm_id            = 312
      name             = "172-16-3-112-worker-02"
      ip_address       = "172.16.3.112/23"
      description      = "worker for K8S"
      tags             = ["dev", "k8s", "worker"]
      cpu_cores        = 4
      memory_dedicated = 12288
      disk_size        = 40
      disk_additional = [
        { size = 200, interface = "virtio1" }
      ]
      clone_vm_id   = 8053
      init_username = var.init_username
      init_password = var.init_password
    }
    worker-03 = {
      vm_id            = 313
      name             = "172-16-3-113-worker-03"
      ip_address       = "172.16.3.113/23"
      description      = "worker for K8S"
      tags             = ["dev", "k8s", "worker"]
      cpu_cores        = 4
      memory_dedicated = 12288
      disk_size        = 40
      disk_additional = [
        { size = 200, interface = "virtio1" }
      ]
      clone_vm_id   = 8053
      init_username = var.init_username
      init_password = var.init_password
    }
  }
}
