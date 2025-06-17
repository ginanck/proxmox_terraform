module "lb_haproxy" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.lb_haproxy_config
}

module "lb_webserver" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.lb_webserver_config
}
