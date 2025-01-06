module "freeipa_vms" {
  source = "../../../base"
  vm_configs = local.freeipa_nodes
}
