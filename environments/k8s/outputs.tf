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
