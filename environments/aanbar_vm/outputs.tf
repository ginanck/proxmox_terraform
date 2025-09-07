output "ansible-lab" {
  description = "IP address of the ansible lab server"
  value       = {
    vm_id = module.ansible-lab.vm_id
    vm_ip = module.ansible-lab.vm_ip
    vm_name = module.ansible-lab.vm_name
  }
}
