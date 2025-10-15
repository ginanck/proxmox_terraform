locals {
  master = {
    master-02 = {
      vm_id      = 302
      name       = "172-16-3-102-master-02"
      ip_address = "172.16.3.102/23"
    }
  }
}

locals {
  worker = {
    worker-02 = {
      vm_id      = 312
      name       = "172-16-3-112-worker-02"
      ip_address = "172.16.3.112/23"
    }
    worker-03 = {
      vm_id      = 313
      name       = "172-16-3-113-worker-03"
      ip_address = "172.16.3.113/23"
    }
  }
}
