# Proxmox Endpoint Connection
variable "proxmox_endpoint" {
  description = "Proxmox terraform connection endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox terraform connection api token"
  type        = string
}

# VM Initialization Variables (secrets that will come from tfvars)
variable "init_username" {
  description = "Default user account username for Harbor VM"
  type        = string
  sensitive   = true
}

variable "init_password" {
  description = "Default user account password for Harbor VM"
  type        = string
  sensitive   = true
}
