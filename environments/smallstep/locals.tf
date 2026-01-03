locals {
  vms = {
    smallstep = {
      vm_id            = 220
      name             = "172-16-2-20-smallstep"
      ip_address       = "172.16.2.20/23"
      description      = "smallstep CA for lab setup"
      tags             = ["dev", "smallstep"]
      cpu_cores        = 2
      memory_dedicated = 2048
      disk_size        = 16
      init_username    = var.init_username
      init_password    = var.init_password
      init_ssh_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
      ]
    }
  }
}
