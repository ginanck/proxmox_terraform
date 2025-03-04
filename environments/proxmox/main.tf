module "pve_cluster" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.pve_cluster
  
  vm = each.value
}
