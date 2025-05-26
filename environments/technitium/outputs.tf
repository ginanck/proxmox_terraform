output "technitium" {
  description = "IP address of the technitium server"
  value       = {
    vm_id = module.technitium.vm_id
    vm_ip = module.technitium.vm_ip
    vm_name = module.technitium.vm_name
  }
}
