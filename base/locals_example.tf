locals {
  common_vm_config = {
    # Basic VM settings
    name            = "vm-test1"
    description     = "Test VM managed by Terraform"
    node_name       = "oxygen"
    vm_id           = 110
    
    # VM behavior settings
    acpi            = true
    bios            = "seabios"
    keyboard_layout = "en-us"
    migrate         = false
    on_boot         = true
    protection      = false
    reboot          = true
    started         = true
    stop_on_destroy = false
    tablet_device   = true
    template        = false
    
    # Hardware settings
    scsi_hardware   = "virtio-scsi-pci"
    
    # Tags
    tags            = ["terraform-managed"]
    
    # Timeouts
    timeouts = {
      clone       = 1800
      create      = 1800
      migrate     = 1800
      reboot      = 1800
      shutdown_vm = 1800
      start_vm    = 1800
      stop_vm     = 300
    }
    
    # Clone settings
    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8052
    }

    # CPU configuration
    cpu = {
      cores      = 1
      hotplugged = 0
      limit      = 0
      numa       = false
      sockets    = 1
      type       = "host"
      units      = 1024
    }
    
    # Memory configuration
    memory = {
      dedicated      = 2048
      floating       = 0
      keep_hugepages = false
      shared         = 0
    }
    
    # Primary disk
    disk = {
      aio          = "io_uring"
      backup       = false
      cache        = "none"
      datastore_id = "data"
      discard      = "ignore"
      interface    = "virtio0"
      file_format  = null
      iothread     = false
      replicate    = false
      size         = 20
      ssd          = false
    }
    
    # Additional disks
    additional_disks = [
      {
        size         = 100
        datastore_id = "data"
        interface    = "virtio1"  # First additional disk
        cache        = "none"
        aio          = "io_uring"
        discard      = "ignore"
        replicate    = false
        ssd          = true
      },
      {
        size         = 150
        datastore_id = "data"
        interface    = "virtio2"  # Second additional disk
        cache        = "none"
        aio          = "io_uring"
        discard      = "ignore"
        replicate    = false
        iothread     = true
      }
    ]
    
    # Primary network device
    network_device = {
      bridge      = "vmbr1"
      enabled     = true
      firewall    = false
      model       = "virtio"
      mac_address = null
      mtu         = 0
      queues      = 0
      rate_limit  = 0
      vlan_id     = 0
    }
    
    # Additional network devices
    additional_network_devices = [
      {
        bridge      = "vmbr2"  # First additional network
        enabled     = true
        firewall    = false
        model       = "virtio"
        mac_address = null  # Auto-generate
        mtu         = 1500  # Custom MTU
        queues      = 4     # For multi-queue network performance
      },
      {
        bridge      = "vmbr3"  # Second additional network
        enabled     = true
        firewall    = true
        model       = "virtio"
        vlan_id     = 100   # Using VLAN 100
        rate_limit  = 100   # Limit bandwidth to 100 Mbps
      }
    ]

    # Initialization
    initialization = {
      datastore_id = "data"
      dns = {
        servers = ["8.8.8.8", "8.8.4.4"]
      }
      ip_config = {
        ipv4 = {
          address = "172.16.2.100/23"
          gateway = "172.16.2.1"
        }
      }
      user_account = {
        keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz"]
        username = "ubuntu"
        password = "ubuntu"
      }
    }
  }
}