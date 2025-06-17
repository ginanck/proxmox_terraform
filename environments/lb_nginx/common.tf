locals {
  common_config = {
    interfaces = {
      vmbr0_mac     = "00:50:56:01:17:1D"
      vmbr0_ip      = "157.180.50.18/26"
      vmbr0_gateway = "157.180.50.1"
    }

    tags        = ["experiment", "loadbalancer", "nginx"]

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8150
    }

    cpu = {
      cores      = 2
    }
    
    memory = {
      dedicated      = 4096
    }

    disk = {
      size = 40
    }

    dns_servers = [
      "8.8.8.8",
      "8.8.4.4"
    ]

    user_account = {
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz"
      ]
      username = "ansible"
      password = "ansible"
    }
  }
}
