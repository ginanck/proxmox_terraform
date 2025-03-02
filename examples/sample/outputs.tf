output "web_server" {
  description = "IP address of the web server"
  value       = {
    vm_id = module.web_server.vm_id
    vm_ip = module.web_server.vm_ip
    vm_name = module.web_server.vm_name
  }
}

output "db_server" {
  description = "IP address of the database server"
  value       = {
    vm_id = module.db_server.vm_id
    vm_ip = module.db_server.vm_ip
    vm_name = module.db_server.vm_name
  }
}

output "app_servers" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.app_servers : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}