module "nginx" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-81-nginx"
  vm_id       = 281
  description = "Nginx for K8S LB"
  tags        = ["dev", "nginx", "loadbalancer"]

  # Hardware
  cpu_cores        = 2
  memory_dedicated = 4096
  disk_size        = 40

  # Network
  network_bridge  = "vmbr1"
  init_gateway    = "172.16.2.1"
  init_ip_address = "172.16.2.81/23"
  init_username   = var.init_username
  init_password   = var.init_password

  # Clone settings
  clone_vm_id = 8150
}

output "vm_details" {
  description = "VM Information"
  value       = module.nginx.vm_details
}
