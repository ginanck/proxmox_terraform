resource "proxmox_virtual_environment_vm" "vms" {
  for_each = { for idx, vm in var.vm_configs : vm.name => vm }

  name            = each.value.name
  description     = each.value.description
  node_name       = each.value.node_name
  vm_id           = each.value.vm_id
  acpi            = each.value.acpi
  bios            = each.value.bios
  keyboard_layout = each.value.keyboard_layout
  migrate         = each.value.migrate
  on_boot         = each.value.on_boot
  protection      = each.value.protection
  reboot          = each.value.reboot
  scsi_hardware   = each.value.scsi_hardware
  started         = each.value.started
  stop_on_destroy = each.value.stop_on_destroy
  tablet_device   = each.value.tablet_device
  template        = each.value.template
  tags            = each.value.tags

  timeout_clone       = each.value.timeouts.clone
  timeout_create      = each.value.timeouts.create
  timeout_migrate     = each.value.timeouts.migrate
  timeout_reboot      = each.value.timeouts.reboot
  timeout_shutdown_vm = each.value.timeouts.shutdown_vm
  timeout_start_vm    = each.value.timeouts.start_vm
  timeout_stop_vm     = each.value.timeouts.stop_vm

  clone {
    datastore_id = each.value.clone.datastore_id
    full         = each.value.clone.full
    retries      = each.value.clone.retries
    vm_id        = each.value.clone.vm_id
  }

  cpu {
    cores      = each.value.cpu.cores
    hotplugged = each.value.cpu.hotplugged
    limit      = each.value.cpu.limit
    numa       = each.value.cpu.numa
    sockets    = each.value.cpu.sockets
    type       = each.value.cpu.type
    units      = each.value.cpu.units
  }

  memory {
    dedicated      = each.value.memory.dedicated
    floating       = each.value.memory.floating
    keep_hugepages = each.value.memory.keep_hugepages
    shared         = each.value.memory.shared
  }

  disk {
    aio           = each.value.disk.aio
    backup        = each.value.disk.backup
    cache         = each.value.disk.cache
    datastore_id  = each.value.disk.datastore_id
    discard       = each.value.disk.discard
    interface     = each.value.disk.interface
    file_format   = each.value.disk.file_format
    iothread      = each.value.disk.iothread
    replicate     = each.value.disk.replicate
    size          = each.value.disk.size
    ssd           = each.value.disk.ssd
  }

  dynamic "disk" {
    for_each = each.value.additional_disks != null ? each.value.additional_disks : []
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
    bridge      = each.value.network_device.bridge
    enabled     = each.value.network_device.enabled
    firewall    = each.value.network_device.firewall
    mac_address = each.value.network_device.mac_address
    model       = each.value.network_device.model
    mtu         = each.value.network_device.mtu
    queues      = each.value.network_device.queues
    rate_limit  = each.value.network_device.rate_limit
    vlan_id     = each.value.network_device.vlan_id
  }

  dynamic "network_device" {
    for_each = each.value.additional_network_devices != null ? each.value.additional_network_devices : []
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
    datastore_id = each.value.initialization.datastore_id

    dns {
      servers = each.value.initialization.dns.servers
    }

    ip_config {
      ipv4 {
        address = each.value.initialization.ip_config.ipv4.address
        gateway = each.value.initialization.ip_config.ipv4.gateway
      }
    }

    user_account {
      keys     = each.value.initialization.user_account.keys
      password = each.value.initialization.user_account.password
      username = each.value.initialization.user_account.username
    }
  }
}
