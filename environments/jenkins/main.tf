module "jenkins_master" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.jenkins_master
  
  vm = each.value
}

module "jenkins_slaves" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.jenkins_slaves
  
  vm = each.value
}
