module "posteio" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.posteio_config
}
