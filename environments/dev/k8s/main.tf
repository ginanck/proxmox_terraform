module "haproxy" {
  source = "../../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.haproxy_config
}

module "nginx" {
  source = "../../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.nginx_config
}

module "nfs" {
  source = "../../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.nfs_config
}

module "k8s_master" {
  source   = "../../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.k8s_master
  
  vm = each.value
}

module "k8s_worker" {
  source   = "../../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.k8s_worker
  
  vm = each.value
}
