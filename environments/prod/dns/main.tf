module "dns_vms" {
  source = "../../../base"
  vm_configs = local.dns_nodes
}
