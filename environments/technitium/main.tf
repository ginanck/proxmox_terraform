module "technitium" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.technitium_config
}
