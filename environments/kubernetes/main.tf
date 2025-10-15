module "k8s_master" {
  source = "../../base"
  for_each = local.master

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = each.value.name
  vm_id       = each.value.vm_id
  description = "master for K8S"
  tags        = ["dev", "k8s", "master"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 40
  
  # Additional storage
  additional_disks = [
    { size = 100, interface = "virtio1" }
  ]
  
  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = each.value.ip_address
  init_username     = "ansible"
  init_password     = "ansible"

  # Clone settings
  clone_vm_id = 8101
}

module "k8s_worker" {
  source = "../../base"
  for_each = local.worker

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = each.value.name
  vm_id       = each.value.vm_id
  description = "worker for K8S"
  tags        = ["dev", "k8s", "worker"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 12288
  disk_size        = 40
  
  # Additional storage
  additional_disks = [
    { size = 200, interface = "virtio1" }
  ]
  
  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = each.value.ip_address
  init_username     = "ansible"
  init_password     = "ansible"

  # Clone settings
  clone_vm_id = 8053
}
