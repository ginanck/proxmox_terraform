module "harbor_vms" {
  source = "../../../base"
  vm_configs = local.harbor_nodes
}
