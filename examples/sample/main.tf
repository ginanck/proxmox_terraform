module "web_server" {
  source = "../../../base"
  providers = {
    proxmox = proxmox
  }

  vm = merge(local.common_vm_config, local.web_server_config)
}

module "db_server" {
  source = "../../../base"
  providers = {
    proxmox = proxmox
  }

  vm = merge(local.common_vm_config, local.db_server_config)
}

module "app_servers" {
  source   = "../../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.app_cluster
  
  vm = merge(
    local.common_vm_config,
    {
      name = each.key  # Use the map key as the VM name
      tags = concat(local.common_vm_config.tags, ["cluster", "app"])
    },
    each.value
  )
}