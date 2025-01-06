variable "vm_configs" {
  description = "List of VM configurations"
  type = list(object({
    name            = optional(string, "vm-test1")
    description     = optional(string, "Test VM managed by Terraform")
    node_name       = optional(string, "oxygen")
    vm_id           = optional(number, 110)
    acpi            = optional(bool, true)
    bios            = optional(string, "seabios")
    keyboard_layout = optional(string, "en-us")
    migrate         = optional(bool, false)
    on_boot         = optional(bool, true)
    protection      = optional(bool, false)
    reboot          = optional(bool, true)
    scsi_hardware   = optional(string, "virtio-scsi-pci")
    started         = optional(bool, true)
    stop_on_destroy = optional(bool, false)
    tablet_device   = optional(bool, true)
    template        = optional(bool, false)
    tags            = optional(list(string),
      [
        "test",
        "test-vm-base"
      ]
    )
    timeouts = optional(object(
      {
        clone       = optional(number, 1800)
        create      = optional(number, 1800)
        migrate     = optional(number, 1800)
        reboot      = optional(number, 1800)
        shutdown_vm = optional(number, 1800)
        start_vm    = optional(number, 1800)
        stop_vm     = optional(number, 300)
      }), {
        clone       = 1800
        create      = 1800
        migrate     = 1800
        reboot      = 1800
        shutdown_vm = 1800
        start_vm    = 1800
        stop_vm     = 300
      }
    )
    clone = optional(object(
      {
        datastore_id = optional(string, "data")
        full         = optional(bool, true)
        retries      = optional(number, 3)
        vm_id        = optional(number, 8052)
      }), {
        datastore_id = "data"
        full         = true
        retries      = 3
        vm_id        = 803
      }
    )
    cpu = object({
      cores      = optional(number, 1)
      hotplugged = optional(number, 0)
      limit      = optional(number, 0)
      numa       = optional(bool, false)
      sockets    = optional(number, 1)
      type       = optional(string, "host")
      units      = optional(number, 1024)
    })
    memory = optional(object(
      {
        dedicated      = optional(number, 2048)
        floating       = optional(number, 0)
        keep_hugepages = optional(bool, false)
        shared         = optional(number, 0)
      }), {
        dedicated      = 2048
        floating       = 0
        keep_hugepages = false
        shared         = 0
      })
    disk = optional(object(
      {
        aio          = optional(string, "io_uring")
        backup       = optional(bool, false)
        cache        = optional(string, "none")
        datastore_id = optional(string, "data")
        discard      = optional(string, "ignore")
        interface    = optional(string, "virtio0")
        file_format  = optional(string)
        iothread     = optional(bool, false)
        replicate    = optional(bool, false)
        size         = optional(number, 10)
        ssd          = optional(bool, false)
      }), {
        aio          = "io_uring"
        backup       = false
        cache        = "none"
        datastore_id = "data"
        discard      = "ignore"
        interface    = "virtio0"
        iothread     = false
        replicate    = false
        size         = 10
        ssd          = false
      }
    )
    additional_disks = optional(list(object({
      aio          = optional(string, "io_uring")
      backup       = optional(bool, false)
      cache        = optional(string, "none")
      datastore_id = optional(string, "data")
      discard      = optional(string, "ignore")
      interface    = optional(string, "virtio1")
      file_format  = optional(string)
      iothread     = optional(bool, false)
      replicate    = optional(bool, false)
      size         = optional(number, 10)
      ssd          = optional(bool, false)
    })))
    network_device = optional(object(
      {
        bridge      = optional(string, "vmbr1")
        enabled     = optional(bool, true)
        firewall    = optional(bool, false)
        model       = optional(string, "virtio")
        mac_address = optional(string)
        mtu         = optional(number, 0)
        queues      = optional(number, 0)
        rate_limit  = optional(number, 0)
        vlan_id     = optional(number, 0)
      }), {
        bridge      = "vmbr1"
        enabled     = true
        firewall    = false
        model       = "virtio"
        mtu         = 0
        queues      = 0
        rate_limit  = 0
        vlan_id     = 0
      }
    )
    additional_network_devices = optional(list(object({
      bridge      = optional(string, "vmbr2")
      enabled     = optional(bool, true)
      firewall    = optional(bool, false)
      mac_address = optional(string)
      model       = optional(string, "virtio")
      mtu         = optional(number, 0)
      queues      = optional(number, 0)
      rate_limit  = optional(number, 0)
      vlan_id     = optional(number, 0)
    })))

    initialization = optional(object({
      datastore_id = optional(string, "data")
      dns = optional(object({
        servers = optional(list(string), ["1.1.1.1", "1.0.0.1"])
      }), {
        servers = ["1.1.1.1", "1.0.0.1"]
      })
      ip_config = optional(object({
        ipv4 = optional(object({
          address = optional(string, "172.16.2.100/24")
          gateway = optional(string, "172.16.2.1")
        }), {
          address = "172.16.2.100/24"
          gateway = "172.16.2.1"
        })
      }), {
        ipv4 = {
          address = "172.16.2.100/24"
          gateway = "172.16.2.1"
        }
      })
      user_account = optional(object({
        keys     = optional(list(string), ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz"])
        password = optional(string, "admin")
        username = optional(string, "admin")
      }), {
        keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz"]
        password = "admin"
        username = "admin"
      })
    }), {
      datastore_id = "data"
      dns = {
        servers = ["1.1.1.1", "1.0.0.1"]
      }
      ip_config = {
        ipv4 = {
          address = "192.168.1.100/24"
          gateway = "192.168.1.1"
        }
      }
      user_account = {
        keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz"]
        password = "admin"
        username = "admin"
      }
    })
  }))

}
