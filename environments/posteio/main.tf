module "posteio" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "157-180-50-19-posteio"
  vm_id       = 102
  description = "Poste.io Dockerized Email Server"
  tags        = ["dev", "posteio"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 20
  disk_additional = [
    { size = 100, interface = "virtio1" }
  ]

  # Network
  network_bridge      = "vmbr0"
  network_mac_address = "00:50:56:01:16:34"
  init_gateway        = "157.180.50.1"
  init_ip_address     = "157.180.50.19/26"
  init_username       = "ansible"
  init_password       = "ansible"

  # Clone settings
  clone_vm_id = 8150
}

output "vm_details" {
  description = "VM Information"
  value = module.posteio.vm_details
}
