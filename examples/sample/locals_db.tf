locals {
  db_server_config = {
    name        = "db-server"
    description = "Database Server VM"
    vm_id       = 222
    
    cpu = {
      cores = 4  # Override the common core count
    }
    
    memory = {
      dedicated = 8192  # Override the common memory
    }
    
    disk = {
      size = 50  # Override the common disk size
    }
    
    additional_disks = [{
      interface    = "virtio1"
      size         = 100
      datastore_id = "data"
      cache        = "none"
    }]

    additional_network_devices = [{
      bridge      = "vmbr2"
      enabled     = true
      firewall    = false
    }]

    initialization = {
      ip_config = {
        ipv4 = {
          address = "172.16.3.222/23"
          gateway = "172.16.2.1"
        }
      }
      ip_config1 = {
        ipv4 = {
          address = "192.168.1.222/24"  # Set the IP for the second interface
          gateway = null  # Typically only one default gateway is needed
        }
      }
    }
  }
}