module "nginx" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.nginx_config
}
