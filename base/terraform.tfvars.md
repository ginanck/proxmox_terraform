vm = {
  # Basic VM settings
  name        = "vm-test1"
  description = "Test VM managed by Terraform"
  node_name   = "oxygen"
  vm_id       = 110
  
  # CPU configuration
  cpu = {
    cores = 2
  }
  
  # Additional storage
  additional_disks = [
    {
      interface = "virtio1"
      size      = 15
    }
  ]
  
  # Network configuration
  additional_network_devices = [
    {
      bridge      = "vmbr1"
      mac_address = "BC:24:11:4D:87:93"
    }
  ]
  
  # Initialization/Cloud-Init configuration
  initialization = {
    dns = {
      servers = ["8.8.8.8", "8.8.4.4"]
    }
    
    ip_config = {
      ipv4 = {
        address = "172.16.2.101/24"
        gateway = "172.16.2.1"
      }
    }
    
    user_account = {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u test@example.com"]
      password = "ubuntu"
      username = "ubuntu"
    }
  }
}