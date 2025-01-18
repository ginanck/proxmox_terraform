module "proxmox_vms" {
  source = "../../../base"
  vm_configs = local.proxmox_nodes
}
