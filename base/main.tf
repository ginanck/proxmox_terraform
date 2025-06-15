resource "proxmox_virtual_environment_vm" "vm" {
  name            = var.vm.name
  description     = var.vm.description
  node_name       = var.vm.node_name
  vm_id           = var.vm.vm_id
  acpi            = var.vm.acpi
  agent {
    enabled       = var.vm.agent.enabled
  }

  bios                  = var.vm.bios
  keyboard_layout       = var.vm.keyboard_layout
  migrate               = var.vm.migrate
  on_boot               = var.vm.on_boot
  protection            = var.vm.protection
  reboot                = var.vm.reboot
  reboot_after_update   = var.vm.reboot_after_update
  scsi_hardware         = var.vm.scsi_hardware
  started               = var.vm.started
  stop_on_destroy       = var.vm.stop_on_destroy
  tablet_device         = var.vm.tablet_device
  template              = var.vm.template
  tags                  = var.vm.tags

  timeout_clone       = var.vm.timeouts.clone
  timeout_create      = var.vm.timeouts.create
  timeout_migrate     = var.vm.timeouts.migrate
  timeout_reboot      = var.vm.timeouts.reboot
  timeout_shutdown_vm = var.vm.timeouts.shutdown_vm
  timeout_start_vm    = var.vm.timeouts.start_vm
  timeout_stop_vm     = var.vm.timeouts.stop_vm

  clone {
    datastore_id = var.vm.clone.datastore_id
    full         = var.vm.clone.full
    retries      = var.vm.clone.retries
    vm_id        = var.vm.clone.vm_id
  }

  cpu {
    cores      = var.vm.cpu.cores
    hotplugged = var.vm.cpu.hotplugged
    limit      = var.vm.cpu.limit
    numa       = var.vm.cpu.numa
    sockets    = var.vm.cpu.sockets
    type       = var.vm.cpu.type
    units      = var.vm.cpu.units
  }

  memory {
    dedicated      = var.vm.memory.dedicated
    floating       = var.vm.memory.floating
    keep_hugepages = var.vm.memory.keep_hugepages
    shared         = var.vm.memory.shared
  }

  disk {
    aio           = var.vm.disk.aio
    backup        = var.vm.disk.backup
    cache         = var.vm.disk.cache
    datastore_id  = var.vm.disk.datastore_id
    discard       = var.vm.disk.discard
    interface     = var.vm.disk.interface
    file_format   = var.vm.disk.file_format
    iothread      = var.vm.disk.iothread
    replicate     = var.vm.disk.replicate
    size          = var.vm.disk.size
    ssd           = var.vm.disk.ssd
  }

  dynamic "disk" {
    for_each = var.vm.additional_disks
    content {
      aio           = disk.value.aio
      backup        = disk.value.backup
      cache         = disk.value.cache
      datastore_id  = disk.value.datastore_id
      discard       = disk.value.discard
      interface     = disk.value.interface
      file_format   = disk.value.file_format
      iothread      = disk.value.iothread
      replicate     = disk.value.replicate
      size          = disk.value.size
      ssd           = disk.value.ssd
    }
  }

  network_device {
    bridge      = var.vm.network_device.bridge
    enabled     = var.vm.network_device.enabled
    firewall    = var.vm.network_device.firewall
    mac_address = var.vm.network_device.mac_address
    model       = var.vm.network_device.model
    mtu         = var.vm.network_device.mtu
    queues      = var.vm.network_device.queues
    rate_limit  = var.vm.network_device.rate_limit
    vlan_id     = var.vm.network_device.vlan_id
  }

  dynamic "network_device" {
    for_each = var.vm.additional_network_devices
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

  initialization {
    datastore_id = var.vm.initialization.datastore_id
    interface    = var.vm.initialization.interface

    dns {
      servers = var.vm.initialization.dns.servers
    }

    ip_config {
      ipv4 {
        address = var.vm.initialization.ip_config.ipv4.address
        gateway = var.vm.initialization.ip_config.ipv4.gateway
      }
    }

    user_account {
      keys     = var.vm.initialization.user_account.keys
      password = var.vm.initialization.user_account.password
      username = var.vm.initialization.user_account.username
    }
  }
}