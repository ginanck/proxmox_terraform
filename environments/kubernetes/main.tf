module "k8s_master" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.k8s_master
  
  vm = each.value
}

resource "null_resource" "disk_resize_master" {
  for_each = local.k8s_master

  depends_on = [module.k8s_master]

  # Trigger when VM is recreated or disk size changes
  triggers = {
    vm_id     = module.k8s_master[each.key].vm_id
    disk_size = each.value.disk.size
  }

  connection {
    type        = "ssh"
    host        = split("/", each.value.initialization.ip_config.ipv4.address)[0]
    user        = each.value.initialization.user_account.username
    private_key = file("~/.ssh/id_ansible") # Adjust path to your private key
    timeout     = "5m"
  }

  # Wait for VM to be ready
  provisioner "remote-exec" {
    inline = [
      "while ! systemctl is-system-running --wait >/dev/null 2>&1; do sleep 5; done",
      "echo 'System is ready'"
    ]
  }

  # Execute disk resize script
  provisioner "remote-exec" {
    inline = [
      "sudo bash -c '${replace(local.disk_resize_script_master, "'", "'\\''")}'"
    ]
  }
}


module "k8s_worker" {
  source   = "../../base"
  providers = {
    proxmox = proxmox
  }
  for_each = local.k8s_worker
  
  vm = each.value
}

resource "null_resource" "disk_resize_worker" {
  for_each = local.k8s_worker

  depends_on = [module.k8s_worker]

  # Trigger when VM is recreated or disk size changes
  triggers = {
    vm_id     = module.k8s_worker[each.key].vm_id
    disk_size = each.value.disk.size
  }

  connection {
    type        = "ssh"
    host        = split("/", each.value.initialization.ip_config.ipv4.address)[0]
    user        = each.value.initialization.user_account.username
    private_key = file("~/.ssh/id_ansible") # Adjust path to your private key
    timeout     = "5m"
  }

  # Wait for VM to be ready
  provisioner "remote-exec" {
    inline = [
      "while ! systemctl is-system-running --wait >/dev/null 2>&1; do sleep 5; done",
      "echo 'System is ready'"
    ]
  }

  # Execute disk resize script
  provisioner "remote-exec" {
    inline = [
      "sudo bash -c '${replace(local.disk_resize_script_worker, "'", "'\\''")}'"
    ]
  }
}
