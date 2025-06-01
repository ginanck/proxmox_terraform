output "posteio" {
  description = "IP address of the posteio server"
  value       = {
    vm_id   = module.posteio.vm_id
    vm_ip   = module.posteio.vm_ip
    vm_name = module.posteio.vm_name
  }
}
