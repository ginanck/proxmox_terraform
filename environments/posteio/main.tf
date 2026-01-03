module "posteio" {
  source = "git::https://github.com/ginanck/terraform-proxmox-vm.git?ref=master"

  providers = {
    proxmox = proxmox
  }

  proxmox_endpoint  = var.proxmox_endpoint
  proxmox_api_token = var.proxmox_api_token

  vms = local.vms

  # Common settings
  clone_vm_id      = 8150
  network_bridge   = "vmbr0"
  init_gateway     = "157.180.50.1"
  init_dns_servers = ["8.8.8.8", "8.8.4.4"]
}
