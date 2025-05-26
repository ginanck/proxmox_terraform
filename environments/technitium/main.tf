module "technitium" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.technitium_config
}

resource "null_resource" "disk_resize" {
  depends_on = [module.technitium]

  # Trigger when VM is recreated or disk size changes
  triggers = {
    vm_id     = module.technitium.vm_id
    disk_size = local.technitium_config.disk.size
  }

  connection {
    type        = "ssh"
    host        = split("/", local.technitium_config.initialization.ip_config.ipv4.address)[0]
    user        = local.technitium_config.initialization.user_account.username
    private_key = file("~/.ssh/id_ansible")
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
      "sudo bash -c '${replace(local.disk_resize_script, "'", "'\\''")}'"
    ]
  }
}
