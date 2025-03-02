output "haproxy" {
  description = "IP address of the haproxy server"
  value       = {
    vm_id = module.haproxy.vm_id
    vm_ip = module.haproxy.vm_ip
    vm_name = module.haproxy.vm_name
  }
}
