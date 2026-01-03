locals {
  vms = {
    technitium = {
      vm_id            = 221
      name             = "172-16-2-21-technitium"
      ip_address       = "172.16.2.21/23"
      description      = "technitium dns server for lab setup"
      tags             = ["dev", "technitium"]
      cpu_cores        = 2
      memory_dedicated = 2048
      disk_size        = 12
      disk_additional = [
        { size = 20, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
      init_ssh_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
      ]
    }
  }
}
