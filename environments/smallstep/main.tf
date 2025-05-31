module "smallstep" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.smallstep_config
}
