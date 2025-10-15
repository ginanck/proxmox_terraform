module "lb_nginx" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "157-180-50-18-lb-nginx"
  vm_id       = 411
  description = "Nginx for experimentation"
  tags        = ["experiment", "loadbalancer", "nginx"]

  # Hardware
  cpu_cores        = 2
  memory_dedicated = 4096
  disk_size        = 40
  
  # Additional storage
  disk_additional = [
    { size = 100, interface = "virtio1" }
  ]
  
  # Network
  network_bridge      = "vmbr1"
  network_mac_address = "00:50:56:01:17:1D"
  network_additional = [
    {
      bridge  = "vmbr1"
      address = "172.16.2.53/23"
      gateway = ""
    }
  ]

  init_gateway        = ""
  init_ip_address     = "dhcp"
  init_username       = "ansible"
  init_password       = "ansible"

  # Clone settings
  clone_vm_id = 8150
}
