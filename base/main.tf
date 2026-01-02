locals {
  host_ip_address = split("/", var.init_ip_address)[0]
}

resource "proxmox_virtual_environment_vm" "vm" {
  # Basic settings
  name        = var.name
  description = var.description
  node_name   = var.node_name
  vm_id       = var.vm_id
  tags        = var.tags

  # VM behavior settings
  acpi                = var.acpi
  bios                = var.bios
  keyboard_layout     = var.keyboard_layout
  migrate             = var.migrate
  on_boot             = var.on_boot
  protection          = var.protection
  reboot              = var.reboot
  reboot_after_update = var.reboot_after_update
  scsi_hardware       = var.scsi_hardware
  started             = var.started
  stop_on_destroy     = var.stop_on_destroy
  tablet_device       = var.tablet_device
  template            = var.template

  # Agent configuration
  agent {
    enabled = var.agent_enabled
  }

  # Timeouts
  timeout_clone       = var.timeout_clone
  timeout_create      = var.timeout_create
  timeout_migrate     = var.timeout_migrate
  timeout_reboot      = var.timeout_reboot
  timeout_shutdown_vm = var.timeout_shutdown_vm
  timeout_start_vm    = var.timeout_start_vm
  timeout_stop_vm     = var.timeout_stop_vm

  # Clone configuration
  clone {
    datastore_id = var.clone_datastore_id
    full         = var.clone_full
    retries      = var.clone_retries
    vm_id        = var.clone_vm_id
  }

  # CPU configuration
  cpu {
    cores      = var.cpu_cores
    hotplugged = var.cpu_hotplugged
    limit      = var.cpu_limit
    numa       = var.cpu_numa
    sockets    = var.cpu_sockets
    type       = var.cpu_type
    units      = var.cpu_units
  }

  # Memory configuration
  memory {
    dedicated      = var.memory_dedicated
    floating       = var.memory_floating
    keep_hugepages = var.memory_keep_hugepages
    shared         = var.memory_shared
  }

  # Primary disk
  disk {
    aio          = var.disk_aio
    backup       = var.disk_backup
    cache        = var.disk_cache
    datastore_id = var.disk_datastore_id
    discard      = var.disk_discard
    interface    = var.disk_interface
    file_format  = var.disk_file_format
    iothread     = var.disk_iothread
    replicate    = var.disk_replicate
    size         = var.disk_size
    ssd          = var.disk_ssd
  }

  # Additional disks
  dynamic "disk" {
    for_each = var.disk_additional
    content {
      aio          = disk.value.aio
      backup       = disk.value.backup
      cache        = disk.value.cache
      datastore_id = disk.value.datastore_id
      discard      = disk.value.discard
      interface    = disk.value.interface
      file_format  = disk.value.file_format
      iothread     = disk.value.iothread
      replicate    = disk.value.replicate
      size         = disk.value.size
      ssd          = disk.value.ssd
    }
  }

  # Primary network device
  network_device {
    bridge      = var.network_bridge
    enabled     = var.network_enabled
    firewall    = var.network_firewall
    mac_address = var.network_mac_address
    model       = var.network_model
    mtu         = var.network_mtu
    queues      = var.network_queues
    rate_limit  = var.network_rate_limit
    vlan_id     = var.network_vlan_id
  }

  # Additional network devices
  dynamic "network_device" {
    for_each = var.network_additional
    content {
      bridge      = network_device.value.bridge
      enabled     = network_device.value.enabled
      firewall    = network_device.value.firewall
      mac_address = network_device.value.mac_address
      model       = network_device.value.model
      mtu         = network_device.value.mtu
      queues      = network_device.value.queues
      rate_limit  = network_device.value.rate_limit
      vlan_id     = network_device.value.vlan_id
    }
  }

  # Initialization (Cloud-Init)
  initialization {
    datastore_id = var.init_datastore_id
    interface    = var.init_interface

    dns {
      servers = var.init_dns_servers
    }

    ip_config {
      ipv4 {
        address = var.init_ip_address
        gateway = var.init_gateway
      }
    }

    # Additional IP configurations
    dynamic "ip_config" {
      for_each = var.additional_ip_configs
      content {
        ipv4 {
          address = ip_config.value.address
          gateway = ip_config.value.gateway
        }
      }
    }

    user_account {
      username = var.init_username
      password = var.init_password
      keys     = var.init_ssh_keys
    }
  }
}

# Wait for WinRM to become available before running provisioners
resource "null_resource" "wait_for_winrm" {
  count = var.is_windows ? 1 : 0

  depends_on = [proxmox_virtual_environment_vm.vm]

  triggers = {
    vm_id = proxmox_virtual_environment_vm.vm.id
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "Waiting for WinRM on ${local.host_ip_address}..."
      for i in $(seq 1 ${var.winrm_max_attempts}); do
        curl -s -o /dev/null -w '' --max-time 3 http://${local.host_ip_address}:5985/wsman && \
          echo "WinRM ready" && sleep ${var.winrm_settle_time} && exit 0
        sleep ${var.winrm_retry_delay}
      done
      echo "WinRM timeout" && exit 1
    EOT
  }
}

resource "null_resource" "configure_disks" {
  count = var.is_windows ? 1 : 0

  depends_on = [
    null_resource.wait_for_winrm,
  ]

  # Trigger on disk size changes (primary + additional disks)
  triggers = {
    disk_config = jsonencode({
      primary          = var.disk_size
      additional_sizes = [for disk in var.disk_additional : disk.size]
    })
  }

  connection {
    type     = "winrm"
    host     = local.host_ip_address
    user     = var.init_username
    password = var.init_password
    port     = 5985
    https    = false
    insecure = true
    timeout  = var.winrm_timeout
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -ExecutionPolicy Bypass -File \"C:\\Program Files\\Cloudbase Solutions\\Cloudbase-Init\\pc2_scripts\\Runtime-ManageDisks.ps1\""
    ]
  }
}
