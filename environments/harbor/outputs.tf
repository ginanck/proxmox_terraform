output "harbor" {
  description = "IP address of the harbor server"
  value       = {
    vm_id = module.harbor.vm_id
    vm_ip = module.harbor.vm_ip
    vm_name = module.harbor.vm_name
  }
}
