output "vm_id" {
  description = "The ID of the created VM"
  value       = proxmox_virtual_environment_vm.vm.vm_id  # Replace 'this' with your actual resource name
}

output "vm_name" {
  description = "The name of the created VM"
  value       = proxmox_virtual_environment_vm.vm.name  # Replace 'this' with your actual resource name
}

output "vm_ip" {
  description = "The name of the created VM"
  value       = proxmox_virtual_environment_vm.vm.initialization[0].ip_config[0].ipv4[0].address  # Replace 'this' with your actual resource name
}