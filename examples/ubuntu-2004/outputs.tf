output "nginx" {
  description = "IP address of the nginx server"
  value       = {
    vm_id = module.nginx.vm_id
    vm_name = module.nginx.vm_name
  }
}
