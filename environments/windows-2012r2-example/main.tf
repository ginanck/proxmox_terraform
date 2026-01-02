module "windows-11" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-18-Win11"
  vm_id       = 105
  description = "Windows 11 - Created from Packer Template 8201"
  tags        = ["windows", "windows-11"]

  bios = "ovmf" # UEFI BIOS required for Windows 11

  cpu_cores        = 4
  cpu_type         = "host"
  memory_dedicated = 8192 # 8GB RAM
  disk_size        = 100  # Extend to 100GB
  disk_interface   = "sata0"
  disk_additional = [
    { size = 200, interface = "sata1" }
  ]

  network_bridge   = "vmbr1"
  init_gateway     = "172.16.2.1"
  init_ip_address  = "172.16.2.18/23"
  init_dns_servers = ["172.16.2.1"]

  init_username = var.init_username
  init_password = var.init_password

  # Clone settings
  clone_vm_id = 8201
}
