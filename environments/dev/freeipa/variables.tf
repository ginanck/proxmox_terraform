variable "vm_configs" {
  description = "List of VM configurations"
  type = list(object({
    name            = string
    vm_id           = number
    cpu = object({
      cores         = number
    })
    additional_disks = optional(list(object({
      interface     = string
      size          = number
    })))
    additional_network_devices = optional(list(object({
      bridge        = string
      mac_address   = string
    })))
    initialization = object({
      dns = object({
        servers     = list(string)
      })
      ip_config = object({
        ipv4 = object({
          address   = string
          gateway   = string
        })
      })
      user_account = object({
        keys       = list(string)
        password   = string
        username   = string
      })
    })
  }))
}
