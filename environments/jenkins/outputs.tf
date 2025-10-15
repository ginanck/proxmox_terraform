output "jenkins_master_vm_details" {
  description = "Jenkins Master VM Information"
  value       = module.jenkins_master.vm_details
}

output "jenkins_slave_vm_details" {
  description = "Jenkins Slave VM Information"
  value       = module.jenkins_slaves
}
