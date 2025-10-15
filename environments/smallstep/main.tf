module "smallstep" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-20-smallstep"
  vm_id       = 220
  description = "smallstep CA for lab setup"
  tags        = ["dev", "smallstep"]

  # Hardware
  cpu_cores        = 2
  memory_dedicated = 2048
  disk_size        = 16

  # Network
  network_bridge  = "vmbr1"
  init_gateway    = "172.16.2.1"
  init_ip_address = "172.16.2.20/23"
  init_username   = var.init_username
  init_password   = var.init_password

  # Clone settings
  clone_vm_id = 8053
}

output "vm_details" {
  description = "VM Information"
  value       = module.smallstep.vm_details
}
