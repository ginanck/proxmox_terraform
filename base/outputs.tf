# Consolidated output for easy viewing
output "vm_details" {
  description = "Complete VM details summary"
  value = {
    vm_id     = proxmox_virtual_environment_vm.vm.vm_id
    vm_name   = proxmox_virtual_environment_vm.vm.name
    vm_ip     = proxmox_virtual_environment_vm.vm.initialization[0].ip_config[0].ipv4[0].address
    node_name = proxmox_virtual_environment_vm.vm.node_name
  }
}
