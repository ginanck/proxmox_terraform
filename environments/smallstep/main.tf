module "smallstep" {
  source = "git::https://github.com/ginanck/terraform-proxmox-vm.git?ref=master"

  providers = {
    proxmox = proxmox
  }

  proxmox_endpoint  = var.proxmox_endpoint
  proxmox_insecure  = var.proxmox_insecure
  proxmox_api_token = var.proxmox_api_token

  clone_vm_id      = 8053
  network_bridge   = "vmbr1"
  init_gateway     = "172.16.2.1"
  init_dns_servers = ["8.8.8.8", "8.8.4.4"]

  vms = local.vms
}
