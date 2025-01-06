module "nfs_vms" {
  source = "../../../base"
  vm_configs = local.nfs_nodes
}
