module "dns" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.dns_config
}