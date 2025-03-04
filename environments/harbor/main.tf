module "harbor" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.harbor_config
}