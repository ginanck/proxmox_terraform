output "smallstep" {
  description = "IP address of the smallstep server"
  value       = {
    vm_id = module.smallstep.vm_id
    vm_ip = module.smallstep.vm_ip
    vm_name = module.smallstep.vm_name
  }
}
