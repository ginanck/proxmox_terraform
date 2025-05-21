locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "172.16.2.81/23"
      vmbr1_gateway = "172.16.2.1"
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
    tags = ["dev", "nginx"]
  }
}
