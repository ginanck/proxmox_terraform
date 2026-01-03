locals {
  vms = {
    ansible_lab = {
      vm_id            = 400
      name             = "172-16-3-200-ansible-lab"
      ip_address       = "172.16.3.200/23"
      description      = "ansible lab"
      tags             = ["ansible-lab"]
      cpu_cores        = 4
      memory_dedicated = 8192
      disk_size        = 20
      disk_additional = [
        { size = 100, interface = "virtio1" }
      ]
      init_username = var.init_username
      init_password = var.init_password
      init_ssh_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdlFN/9Nq77zNd4SayTN+y5j+fZWmXK1CynQU7jou3j ansible@aanbar-lab"
      ]
    }
  }
}
