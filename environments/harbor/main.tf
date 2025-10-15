module "harbor" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-35-harbor"
  description = "Harbor for Docker Registry"
  vm_id       = 235
  node_name   = "carbon"
  tags        = ["dev", "harbor", "registry"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 20
  bios             = "seabios"
  
  # Additional storage
  additional_disks = [
    { size = 200, interface = "virtio1" }
  ]
  
  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = "172.16.2.35/23"

  # Clone settings
  clone_vm_id = 8150
}

output "vm_details" {
  description = "VM Information"
  value = module.harbor.vm_details
}
