output "jenkins_master" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.jenkins_master : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}

output "jenkins_slaves" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.jenkins_slaves : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}
