output "pve_cluster" {
  description = "Details of all application servers in the cluster"
  value = {
    for name, server in module.pve_cluster : name => {
      vm_id = server.vm_id
      vm_ip = server.vm_ip
    }
  }
}
