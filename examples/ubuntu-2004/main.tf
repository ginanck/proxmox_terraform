module "nginx" {
  source = "../../base"
  providers = {
    proxmox = proxmox
  }

  vm = local.nginx_config
}

resource "local_file" "config_script" {
  content = templatefile("${path.module}/templates/network-config.sh.tpl", {
    dns_servers = join(", ", local.common_config.dns_servers)
    ens18_iface   = local.common_config.interfaces.vmbr0_iface
    ens18_ip      = local.common_config.interfaces.vmbr0_ip
    ens18_mac     = local.common_config.interfaces.vmbr0_mac
    ens19_iface   = local.common_config.interfaces.vmbr1_iface
    ens19_ip      = local.common_config.interfaces.vmbr1_ip
    ens19_gateway = local.common_config.interfaces.vmbr1_gateway
    ens19_netmask = local.common_config.interfaces.vmbr1_netmask
    ens19_subnet  = local.common_config.interfaces.vmbr1_subnet
  })
  filename = "${path.module}/network-config.sh"
  file_permission = "0755"
}

resource "null_resource" "post_deployment_configuration" {
  depends_on = [module.nginx]
  
  provisioner "local-exec" {
    command = "sleep 15"
  }

  provisioner "local-exec" {
    command = <<-EOT
      timeout=300
      counter=0
      echo "Waiting for SSH port to become available on ${local.common_config.interfaces.vmbr0_ip}..."
      until nc -z -w 5 ${local.common_config.interfaces.vmbr0_ip} 22 || [ $counter -eq $timeout ]; do
        sleep 2
        counter=$((counter+2))
        echo "Still waiting for SSH port... ($counter seconds so far)"
      done
      
      if [ $counter -eq $timeout ]; then
        echo "Timed out waiting for SSH port to become available!"
        exit 1
      else
        echo "SSH port is now available!"
      fi
    EOT
  }

  provisioner "file" {
    source      = local_file.config_script.filename
    destination = "/tmp/network-config.sh"
    
    connection {
      type        = "ssh"
      user        = local.common_config.user_account.username
      password    = local.common_config.user_account.password
      host        = local.common_config.interfaces.vmbr0_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/network-config.sh",
      "sudo /tmp/network-config.sh"
    ]

    connection {
      type        = "ssh"
      user        = local.common_config.user_account.username
      password    = local.common_config.user_account.password
      host        = local.common_config.interfaces.vmbr0_ip
    }
  }

  provisioner "local-exec" {
    command = "rm -rf ${path.module}/network-config.sh"
  }
}
