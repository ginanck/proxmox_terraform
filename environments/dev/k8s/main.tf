module "k8s_master_vms" {
  source = "../../../base"
  vm_configs = local.master_nodes
}

module "k8s_worker_vms" {
  source = "../../../base"
  vm_configs = local.worker_nodes
}
