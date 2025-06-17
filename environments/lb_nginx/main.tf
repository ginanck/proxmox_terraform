module "lb_nginx" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.lb_nginx_config
}

module "lb_webserver" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.lb_webserver_config
}
