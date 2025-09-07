module "ansible-lab" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.vm_config
}
