output "gitea" {
  description = "IP address of the gitea server"
  value       = {
    vm_id = module.gitea.vm_id
    vm_ip = module.gitea.vm_ip
    vm_name = module.gitea.vm_name
  }
}
