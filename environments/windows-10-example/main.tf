module "windows-10" {
  source = "../../base"

  providers = {
    proxmox = proxmox
  }

  # Basic settings
  name        = "172-16-3-220-Win10"
  vm_id       = 2801
  description = "Windows 10"
  tags        = ["windows", "windows-10"]

  bios = "ovmf"

  cpu_cores = 4
  cpu_type  = "host"

  memory_dedicated = 8192
  disk_size        = 100
  disk_interface   = "sata0"

  disk_additional = [
    { size = 200, interface = "sata1" }
  ]

  network_bridge   = "vmbr1"
  init_gateway     = "172.16.2.1"
  init_ip_address  = "172.16.3.220/23"
  init_dns_servers = ["172.16.2.1"]

  init_username = var.init_username
  init_password = var.init_password

  # Clone settings
  clone_vm_id = 7954

  force_update = false

  is_windows = true
}
