module "harbor" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-35-harbor"
  vm_id       = 235
  description = "Harbor for Docker Registry"
  tags        = ["dev", "harbor", "registry"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 20
  
  # Additional storage
  disk_additional = [
    { size = 200, interface = "virtio1" }
  ]
  
  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = "172.16.2.35/23"
  init_username     = "ansible"
  init_password     = "ansible"

  # Clone settings
  clone_vm_id = 8150
}

output "vm_details" {
  description = "VM Information"
  value = module.harbor.vm_details
}
