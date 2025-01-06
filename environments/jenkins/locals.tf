locals {
  slaves = {
    slave01 = {
      vm_id       = 242
      name        = "172-16-2-42-jenkins-slave-01"
      ip_address  = "172.16.2.42/23"
    }
    slave02 = {
      vm_id       = 243
      name        = "172-16-2-43-jenkins-slave-02"
      ip_address  = "172.16.2.43/23"
    }
  }
}
