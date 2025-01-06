module "haproxy_vms" {
  source = "../../../base"
  vm_configs = local.haproxy_nodes
}
