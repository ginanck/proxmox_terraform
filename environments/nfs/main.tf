module "nfs_server" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.nfs_server_config
}
