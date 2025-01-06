vm_configs = [
  {
    name            = "vm-test1"
    vm_id           = 110
    cpu = {
      cores         = 2
    }
    additional_disks = [
      {
        interface   = "virtio1"
        size        = 15
      }
    ]
    additional_network_devices = [
      {
        bridge = "vmbr2"
        mac_address = "BC:24:11:4D:87:93"
      }
    ]
    initialization = {
      dns = {
        servers     = ["8.8.8.8", "8.8.4.4"]
      }
      ip_config = {
        ipv4 = {
          address   = "172.16.2.101/24"
          gateway   = "172.16.2.1"
        }
      }
      user_account = {
        keys        = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u test@example.com"]
        password    = "ubuntu"
        username    = "ubuntu"
      }
    }
  },
  {
    name            = "vm-test2"
    vm_id           = 111
    cpu = {
      cores         = 2
    }
    additional_disks = [
      {
        interface   = "virtio1"
        size        = 20
      }
    ]
    additional_network_devices = [
      {
        bridge      = "vmbr2"
        mac_address = "BC:24:11:4D:87:83"
      }
    ]
    initialization = {
      dns = {
        servers     = ["8.8.8.8", "8.8.4.4"]
      }
      ip_config = {
        ipv4 = {
          address   = "172.16.2.102/24"
          gateway   = "172.16.2.1"
        }
      }
      user_account = {
        keys        = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u test@example.com"]
        password    = "ubuntu"
        username    = "ubuntu"
      }
    }

  }

]
