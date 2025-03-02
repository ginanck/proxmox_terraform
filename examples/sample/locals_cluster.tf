locals {  
  app_cluster = {
    "app-server-1" = {
      description = "App Server 1 - Cluster Member"
      vm_id       = 225
      initialization = {
        ip_config = {
          ipv4 = {
            address = "172.16.3.225/23"
            gateway = "172.16.2.1"
          }
        }
      }
    }
    "app-server-2" = {
      description = "App Server 2 - Cluster Member"
      vm_id       = 226
      initialization = {
        ip_config = {
          ipv4 = {
            address = "172.16.3.226/23"
            gateway = "172.16.2.1"
          }
        }
      }
    }
    "app-server-3" = {
      description = "App Server 3 - Cluster Member"
      vm_id       = 227
      initialization = {
        ip_config = {
          ipv4 = {
            address = "172.16.3.227/23"
            gateway = "172.16.2.1"
          }
        }
      }
    }
  }
}