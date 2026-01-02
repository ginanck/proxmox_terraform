module "windows-10" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-2-19-Win10"
  vm_id       = 2801
  description = "Windows 10 - Created from Packer Template 8202"
  tags        = ["windows", "windows-10"]

  bios = "ovmf" # UEFI BIOS required for Windows 10

  cpu_cores        = 4
  cpu_type         = "host"
  memory_dedicated = 8192 # 8GB RAM
  disk_size        = 130  # Extend to 100GB
  disk_interface   = "sata0"

  network_bridge   = "vmbr1"
  init_gateway     = "172.16.2.1"
  init_ip_address  = "172.16.2.19/23"
  init_dns_servers = ["172.16.2.1"]

  init_username = var.init_username
  init_password = var.init_password

  # Clone settings
  clone_vm_id = 7901

  is_windows = true
}
