locals {
  web_server_config = {
    name        = "web-server"
    description = "Web Server VM"
    vm_id       = 221
    
    disk = {
      size = 25  # Override the common disk size
    }
    
    initialization = {
      ip_config = {
        ipv4 = {
          address = "172.16.3.221/23"
          gateway = "172.16.2.1"
        }
      }
    }
  }
}