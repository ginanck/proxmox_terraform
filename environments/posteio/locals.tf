locals {
  vms = {
    posteio = {
      vm_id            = 102
      name             = "157-180-50-19-posteio"
      ip_address       = "157.180.50.19/26"
      description      = "Poste.io Dockerized Email Server"
      tags             = ["dev", "posteio"]
      cpu_cores        = 4
      memory_dedicated = 8192
      disk_size        = 20
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      network_mac_address = "00:50:56:01:16:34"
      init_username       = var.init_username
      init_password       = var.init_password
      init_ssh_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
      ]
    }
  }
}
