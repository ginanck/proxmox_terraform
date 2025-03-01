locals {
  # Common configuration that can be shared across all node types
  common_config = {
    dns_servers = ["8.8.8.8", "8.8.4.4"]
    gateway     = "172.16.2.1"
    user_account = {
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz"]
      username = "ubuntu"
      password = "ubuntu"
    }
    tags = ["dev", "k8s"]
  }
}