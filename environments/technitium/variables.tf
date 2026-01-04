# Proxmox Endpoint Connection
variable "proxmox_endpoint" {
  description = "Proxmox terraform connection endpoint"
  type        = string
}

variable "proxmox_insecure" {
  description = "Disable TLS verification for Proxmox API"
  type        = bool
  default     = true
}

variable "proxmox_api_token" {
  description = "Proxmox terraform connection api token"
  type        = string
}

variable "init_username" {
  description = "Default username for cloud-init"
  type        = string
  default     = "ansible"
}

variable "init_password" {
  description = "Default password for cloud-init user"
  type        = string
  sensitive   = true
  default     = "ansible"
}
