locals {
  common_config = {
    interfaces = {
      vmbr0_iface   = "ens18"
      vmbr0_ip      = "65.109.108.143"
      vmbr0_mac     = "00:50:56:01:23:9C"
      vmbr1_iface   = "ens19"
      vmbr1_ip      = "172.16.2.71"
      vmbr1_netmask = "23"
      vmbr1_gateway = "172.16.2.1"
      vmbr1_subnet  = "172.16.2.0/23"
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
    tags = ["dev", "haproxy"]
  }
}