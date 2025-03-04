module "ipa_cluster" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.ipa_cluster
  
  vm = each.value
}
