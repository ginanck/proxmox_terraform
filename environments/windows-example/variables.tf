variable "init_username" {
  description = "Default username for cloud-init"
  type        = string
  default     = "Administrator"
}

variable "init_password" {
  description = "Default password for cloud-init user"
  type        = string
  sensitive   = true
  default     = "Passw0rd1"
}
