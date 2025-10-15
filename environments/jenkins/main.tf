module "jenkins_master" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-41-jenkins-master"
  vm_id       = 241
  description = "Master for Jenkins"
  tags        = ["dev", "jenkins", "master"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 8192
  disk_size        = 20
  
  # Additional storage
  additional_disks = [
    { size = 100, interface = "virtio1" }
  ]
  
  # Network
  network_bridge    = "vmbr1"
  init_gateway      = "172.16.2.1"
  init_ip_address   = "172.16.2.41/23"
  init_username     = "ansible"
  init_password     = "ansible"

  # Clone settings
  clone_vm_id = 8150
}

module "jenkins_slaves" {
  source = "../../base"
  for_each = local.slaves

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = each.value.name
  vm_id       = each.value.vm_id
  description = "Slave for Jenkins"
  tags        = ["dev", "jenkins", "slave"]

  # Hardware
  cpu_cores        = 4
  memory_dedicated = 4096
  disk_size        = 20
  
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
  clone_vm_id = 8150
}
