locals {
  haproxy_config = {
    name        = "haproxy"
    description = "HAProxy for K8S LB"
    vm_id       = 221
    tags        = ["dev", "k8s", "haproxy"]

    cpu = {
      cores      = 2
    }

    memory = {
      dedicated      = 2048
      floating       = 1024
    }

    disk = {
      size = 40
    }

    network_device = {
      bridge   = "vmbr0"
      model    = "virtio"
      mac_address = "00:50:56:01:23:9C"
    }

    additional_network_devices = [
      {
        bridge      = "vmbr1"
        model       = "virtio"
      }
    ]

    initialization = {
      dns = {
        servers = ["8.8.8.8", "8.8.4.4"]
      }
      ip_config = {
        ipv4 = {
          address = "dhcp"
        }
      }
      user_account = local.common_config.user_account
    }
  }
}