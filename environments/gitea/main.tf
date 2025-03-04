module "gitea" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.gitea_config
}