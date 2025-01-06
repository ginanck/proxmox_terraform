output "k8s_master_vm_details" {
  description = "K8S Master VM Information"
  value = module.k8s_master
}

output "k8s_worker_vm_details" {
  description = "K8S Worker VM Information"
  value = module.k8s_worker
}
