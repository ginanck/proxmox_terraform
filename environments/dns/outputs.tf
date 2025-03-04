output "dns" {
  description = "IP address of the dns server"
  value       = {
    vm_id = module.dns.vm_id
    vm_ip = module.dns.vm_ip
    vm_name = module.dns.vm_name
  }
}
