module "ansible-lab" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-3-200-ansible-lab"
  vm_id       = 400
  description = "ansible lab"
  tags        = ["ansible-lab"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 20

  # Additional storage
  disk_additional = [
    { size = 100, interface = "virtio1" }
  ]

  # Network
  network_bridge  = "vmbr1"
  init_gateway    = "172.16.2.1"
  init_ip_address = "172.16.3.200/23"
  init_username   = var.init_username
  init_password   = var.init_password
  init_ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdlFN/9Nq77zNd4SayTN+y5j+fZWmXK1CynQU7jou3j ansible@aanbar-lab"
  ]

  # Clone settings
  clone_vm_id = 8053
}

output "vm_details" {
  description = "VM Information"
  value       = module.ansible-lab.vm_details
}
