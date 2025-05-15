output "nfs_server" {
  description = "IP address of the haproxy server"
  value       = {
    vm_id = module.nfs_server.vm_id
    vm_ip = module.nfs_server.vm_ip
    vm_name = module.nfs_server.vm_name
  }
}
