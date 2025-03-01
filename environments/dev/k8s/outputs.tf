output "haproxy" {
  description = "IP address of the haproxy server"
  value       = {
    vm_id = module.haproxy.vm_id
    vm_ip = module.haproxy.vm_ip
    vm_name = module.haproxy.vm_name
  }
}

output "nginx" {
  description = "IP address of the nginx server"
  value       = {
    vm_id = module.nginx.vm_id
    vm_ip = module.nginx.vm_ip
    vm_name = module.nginx.vm_name
  }
}

output "nfs" {
  description = "IP address of the nginx server"
  value       = {
    vm_id = module.nfs.vm_id
    vm_ip = module.nfs.vm_ip
    vm_name = module.nfs.vm_name
  }
}

output "k8s_worker" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.k8s_worker : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}

output "k8s_master" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.k8s_master : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}
