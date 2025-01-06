module "jenkins_master_vms" {
  source = "../../../base"
  vm_configs = local.master_nodes
}
