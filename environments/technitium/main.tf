module "technitium" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-21-technitium"
  vm_id       = 221
  description = "technitium dns server for lab setup"
  tags        = ["dev", "technitium"]

  # Hardware
  cpu_cores        = 2
  memory_dedicated = 2048
  disk_size        = 12
  additional_disks = [
    { size = 20, interface = "virtio1" }
  ]

  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = "172.16.2.21/23"
  init_username     = "ansible"
  init_password     = "ansible"

  # Clone settings
  clone_vm_id = 8053
}

output "vm_details" {
  description = "VM Information"
  value = module.technitium.vm_details
}
