# Proxmox Virtual Machine Terraform Module

This Terraform module allows you to easily provision and manage Virtual Machines in a Proxmox environment with extensive configuration options.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Provider Configuration](#provider-configuration)
- [Module Usage](#module-usage)
- [Input Variables](#input-variables)
- [Outputs](#outputs)
- [Examples](#examples)

## Prerequisites

- Terraform >= 1.0.0
- Proxmox VE environment
- Administrative access to Proxmox
- [Proxmox Provider](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) credentials

## Provider Configuration

This module uses the `bpg/proxmox` provider. You need to configure the provider in your root module:

```tf
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://proxmox.example.com:8006/api2/json"  # Your Proxmox API endpoint
  username = "user@pam"                                    # Your Proxmox username
  password = "your-password"                               # Your Proxmox password
  
  # Alternatively, use API token
  # api_token = "USER@REALM!TOKENID=UUID"
  
  insecure = true  # Set to false in production
}
```

## Module Usage

Basic usage example:

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = {
    name        = "web-server"
    description = "Web Server VM"
    node_name   = "pve-node1"
    vm_id       = 120
    
    cpu = {
      cores = 2
    }
    
    # All other settings will use defaults from variables.tf
  }
}
```

## Input Variables

The module accepts a single complex variable `vm` that contains all configuration options. Most parameters have sensible defaults defined in `variables.tf`.

### Basic VM Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `name` | Name of the VM | `"vm-test1"` |
| `description` | Description of the VM | `"Test VM managed by Terraform"` |
| `node_name` | Proxmox node name where VM will be created | `"oxygen"` |
| `vm_id` | VM ID in Proxmox | `110` |
| `acpi` | Enable/disable ACPI | `true` |
| `bios` | BIOS type (seabios or ovmf) | `"seabios"` |
| `keyboard_layout` | Keyboard layout | `"en-us"` |
| `migrate` | Allow VM migration | `false` |
| `on_boot` | Start VM on boot | `true` |
| `protection` | Enable VM protection | `false` |
| `reboot` | Allow VM reboot | `true` |
| `started` | Start VM after creation | `true` |
| `stop_on_destroy` | Stop VM when destroyed | `false` |
| `tablet_device` | Enable tablet device | `true` |
| `template` | Make VM a template | `false` |
| `scsi_hardware` | SCSI controller type | `"virtio-scsi-pci"` |
| `tags` | VM tags | `["test", "test-vm-base"]` |

### CPU Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `cpu.cores` | Number of CPU cores | `1` |
| `cpu.hotplugged` | Hotplugged CPUs | `0` |
| `cpu.limit` | CPU usage limit (0 for unlimited) | `0` |
| `cpu.numa` | NUMA enabled | `false` |
| `cpu.sockets` | Number of CPU sockets | `1` |
| `cpu.type` | CPU type | `"host"` |
| `cpu.units` | CPU units for scheduling | `1024` |

### Memory Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `memory.dedicated` | VM memory in MB | `2048` |
| `memory.floating` | Floating memory | `0` |
| `memory.keep_hugepages` | Keep hugepages | `false` |
| `memory.shared` | Shared memory | `0` |

### Disk Configuration

#### Primary Disk

| Parameter | Description | Default |
|-----------|-------------|---------|
| `disk.aio` | AIO type | `"io_uring"` |
| `disk.backup` | Include in backups | `false` |
| `disk.cache` | Disk cache mode | `"none"` |
| `disk.datastore_id` | Storage location | `"data"` |
| `disk.discard` | Discard mode | `"ignore"` |
| `disk.interface` | Disk interface | `"virtio0"` |
| `disk.iothread` | Enable IO thread | `false` |
| `disk.replicate` | Replicate disk | `false` |
| `disk.size` | Disk size in GB | `10` |
| `disk.ssd` | Emulate SSD | `false` |

#### Additional Disks

Additional disks can be specified using the `additional_disks` parameter, which accepts a list of objects with the same parameters as the primary disk.

### Network Configuration

#### Primary Network Device

| Parameter | Description | Default |
|-----------|-------------|---------|
| `network_device.bridge` | Bridge device | `"vmbr1"` |
| `network_device.enabled` | Enable network device | `true` |
| `network_device.firewall` | Enable firewall | `false` |
| `network_device.model` | Network device model | `"virtio"` |
| `network_device.mac_address` | MAC address | `null` |
| `network_device.mtu` | MTU size | `0` |
| `network_device.queues` | Number of queues | `0` |
| `network_device.rate_limit` | Rate limit in MB/s | `0` |
| `network_device.vlan_id` | VLAN ID | `0` |

#### Additional Network Devices

Additional network devices can be specified using the `additional_network_devices` parameter, which accepts a list of objects with the same parameters as the primary network device.

### Initialization Configuration (Cloud-Init)

| Parameter | Description | Default |
|-----------|-------------|---------|
| `initialization.datastore_id` | Storage for cloud-init disk | `"data"` |
| `initialization.dns.servers` | DNS servers | `["1.1.1.1", "1.0.0.1"]` |
| `initialization.ip_config.ipv4.address` | IPv4 address with CIDR | `"172.16.2.100/24"` |
| `initialization.ip_config.ipv4.gateway` | IPv4 gateway | `"172.16.2.1"` |
| `initialization.user_account.keys` | SSH keys | See variables.tf |
| `initialization.user_account.password` | User password | `"admin"` |
| `initialization.user_account.username` | Username | `"admin"` |

### Clone Settings

| Parameter | Description | Default |
|-----------|-------------|---------|
| `clone.datastore_id` | Target datastore | `"data"` |
| `clone.full` | Full clone (vs. linked clone) | `true` |
| `clone.retries` | Retry count | `3` |
| `clone.vm_id` | Source VM/template ID | `8052` |

### Timeouts Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `timeouts.clone` | Timeout for cloning | `1800` |
| `timeouts.create` | Timeout for VM creation | `1800` |
| `timeouts.migrate` | Timeout for VM migration | `1800` |
| `timeouts.reboot` | Timeout for VM reboot | `1800` |
| `timeouts.shutdown_vm` | Timeout for VM shutdown | `1800` |
| `timeouts.start_vm` | Timeout for VM startup | `1800` |
| `timeouts.stop_vm` | Timeout for VM stop | `300` |

## Outputs

The module provides the following outputs:

| Output Name | Description |
|-------------|-------------|
| `vm_id`     | The ID of the created VM |
| `vm_name`   | The name of the created VM |
| `vm_ip`     | The IP address of the created VM |

You can access these outputs from your root module:

```tf
output "proxmox_vm_id" {
  value = module.proxmox_vm.vm_id
}

output "proxmox_vm_ip" {
  value = module.proxmox_vm.vm_ip
}
```

## Examples

### Basic VM

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = {
    name        = "web-server"
    description = "Web Server VM"
    node_name   = "pve-node1"
    vm_id       = 120
    
    cpu = {
      cores = 2
    }
    
    memory = {
      dedicated = 4096
    }
  }
}
```

### VM with Cloud-Init and Custom Network

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = {
    name        = "app-server"
    description = "Application Server"
    node_name   = "pve-node1"
    vm_id       = 121
    
    cpu = {
      cores = 4
    }
    
    memory = {
      dedicated = 8192
    }
    
    network_device = {
      bridge      = "vmbr0"
      mac_address = "BC:24:11:4D:87:A0"
      vlan_id     = 10
    }
    
    additional_network_devices = [
      {
        bridge      = "vmbr1"
        mac_address = "BC:24:11:4D:87:A1"
        vlan_id     = 20
      }
    ]
    
    initialization = {
      dns = {
        servers = ["8.8.8.8", "8.8.4.4"]
      }
      
      ip_config = {
        ipv4 = {
          address = "172.16.2.101/24"
          gateway = "172.16.2.1"
        }
      }
      
      user_account = {
        keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u user@example.com"]
        password = "ubuntu"
        username = "ubuntu"
      }
    }
  }
}
```

### VM with Additional Storage

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = {
    name        = "db-server"
    description = "Database Server"
    node_name   = "pve-node1"
    vm_id       = 122
    
    cpu = {
      cores = 8
    }
    
    memory = {
      dedicated = 16384
    }
    
    disk = {
      size         = 30
      datastore_id = "local-lvm"
      ssd          = true
    }
    
    additional_disks = [
      {
        interface    = "virtio1"
        size         = 100
        datastore_id = "local-lvm"
        ssd          = true
      },
      {
        interface    = "virtio2"
        size         = 200
        datastore_id = "local-lvm"
      }
    ]
  }
}
```

### Clone From Template

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = {
    name        = "clone-from-template"
    description = "VM cloned from template"
    node_name   = "pve-node1"
    vm_id       = 123
    
    cpu = {
      cores = 2
    }
    
    clone = {
      vm_id        = 9000  # Source template ID
      datastore_id = "local-lvm"
      full         = true
    }
    
    initialization = {
      ip_config = {
        ipv4 = {
          address = "172.16.2.102/24"
          gateway = "172.16.2.1"
        }
      }
    }
  }
}
```

### Complete Example

Here's a comprehensive example showcasing most available options:

```tf
module "proxmox_vm" {
  source = "bitbucket.org/ginanck/proxmox_terraform"
  
  vm = {
    # Basic VM settings
    name            = "complete-example"
    description     = "Complete example VM"
    node_name       = "pve-node1"
    vm_id           = 200
    
    # VM behavior settings
    acpi            = true
    bios            = "seabios"
    keyboard_layout = "en-us"
    migrate         = false
    on_boot         = true
    protection      = true
    reboot          = true
    started         = true
    stop_on_destroy = true
    tablet_device   = true
    template        = false
    
    # Hardware settings
    scsi_hardware   = "virtio-scsi-pci"
    
    # Tags
    tags            = ["prod", "example", "complete"]
    
    # Timeouts
    timeouts = {
      clone       = 1800
      create      = 1800
      migrate     = 1800
      reboot      = 1800
      shutdown_vm = 1800
      start_vm    = 1800
      stop_vm     = 300
    }
    
    # Clone settings
    clone = {
      datastore_id = "local-lvm"
      full         = true
      retries      = 3
      vm_id        = 9000
    }
    
    # CPU configuration
    cpu = {
      cores      = 4
      hotplugged = 0
      limit      = 0
      numa       = false
      sockets    = 1
      type       = "host"
      units      = 1024
    }
    
    # Memory configuration
    memory = {
      dedicated      = 4096
      floating       = 0
      keep_hugepages = false
      shared         = 0
    }
    
    # Primary disk
    disk = {
      aio          = "io_uring"
      backup       = true
      cache        = "none"
      datastore_id = "local-lvm"
      discard      = "ignore"
      interface    = "virtio0"
      iothread     = false
      replicate    = false
      size         = 30
      ssd          = true
    }
    
    # Additional disks
    additional_disks = [
      {
        interface    = "virtio1"
        size         = 50
        datastore_id = "local-lvm"
        cache        = "none"
        ssd          = true
      },
      {
        interface    = "virtio2"
        size         = 100
        datastore_id = "local-lvm"
        backup       = true
      }
    ]
    
    # Primary network device
    network_device = {
      bridge      = "vmbr0"
      enabled     = true
      firewall    = false
      model       = "virtio"
      mac_address = "BC:24:11:4D:87:B0"
      mtu         = 0
      queues      = 0
      rate_limit  = 0
      vlan_id     = 10
    }
    
    # Additional network devices
    additional_network_devices = [
      {
        bridge      = "vmbr1"
        enabled     = true
        firewall    = false
        mac_address = "BC:24:11:4D:87:B1"
        model       = "virtio"
        vlan_id     = 20
      },
      {
        bridge      = "vmbr2"
        mac_address = "BC:24:11:4D:87:B2"
        vlan_id     = 30
      }
    ]

    # Initialization/Cloud-Init
    initialization = {
      datastore_id = "local-lvm"
      
      dns = {
        servers = ["8.8.8.8", "8.8.4.4"]
      }
      
      ip_config = {
        ipv4 = {
          address = "192.168.1.100/24"
          gateway = "192.168.1.1"
        }
      }
      
      user_account = {
        keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u user@example.com"]
        password = "secure-password"
        username = "admin"
      }
    }
  }
}
```

## Advanced Usage

### Modifying Default Values

While the module provides sensible defaults, you might want to modify them globally for your infrastructure. One approach is to create a wrapper module:

```tf
# modules/my-proxmox-vm/main.tf
module "proxmox_vm_base" {
  source = "bitbucket.org/ginanck/proxmox_terraform"

  vm = merge({
    # Your organization's defaults
    tags       = ["managed-by-terraform", "org-name"]
    scsi_hardware = "virtio-scsi-single"
    
    initialization = {
      dns = {
        servers = ["10.0.0.10", "10.0.0.11"]  # Internal DNS servers
      }
    }
  }, var.vm)
}

# Passthrough all outputs
output "vm_id" {
  value = module.proxmox_vm_base.vm_id
}

output "vm_name" {
  value = module.proxmox_vm_base.vm_name
}

output "vm_ip" {
  value = module.proxmox_vm_base.vm_ip
}
```

```tf
# modules/my-proxmox-vm/variables.tf
variable "vm" {
  description = "VM configuration"
  type        = any
}
```

Then use your wrapper module:

```tf
module "app_server" {
  source = "./modules/my-proxmox-vm"

  vm = {
    name        = "app-server"
    description = "Application Server"
    vm_id       = 300
    
    cpu = {
      cores = 2
    }
  }
}
```

### Working with Multiple VMs

You can create multiple VMs using the `for_each` meta-argument:

```tf
locals {
  vms = {
    web1 = {
      name     = "web-server-1"
      vm_id    = 201
      ip       = "192.168.1.101/24"
      cores    = 2
      memory   = 2048
    },
    web2 = {
      name     = "web-server-2"
      vm_id    = 202
      ip       = "192.168.1.102/24"
      cores    = 2
      memory   = 2048
    },
    db = {
      name     = "db-server"
      vm_id    = 203
      ip       = "192.168.1.103/24"
      cores    = 4
      memory   = 8192
    }
  }
}

module "proxmox_vms" {
  source   = "bitbucket.org/ginanck/proxmox_terraform"
  for_each = local.vms
  
  vm = {
    name        = each.value.name
    description = "VM managed by Terraform"
    vm_id       = each.value.vm_id
    node_name   = "proxmox-node1"
    
    cpu = {
      cores = each.value.cores
    }
    
    memory = {
      dedicated = each.value.memory
    }
    
    initialization = {
      ip_config = {
        ipv4 = {
          address = each.value.ip
          gateway = "192.168.1.1"
        }
      }
    }
  }
}

output "vm_ips" {
  value = {
    for k, v in module.proxmox_vms : k => v.vm_ip
  }
}
```

## Troubleshooting

### Common Issues

1. **Authentication Issues**:
   Make sure your Proxmox API credentials are correct and have sufficient permissions.

2. **Resource Already Exists**:
   If you're getting errors about VM IDs already existing, make sure to use unique IDs or destroy the existing resources first.

3. **Clone Failures**:
   Ensure that the source template exists and is accessible from the target node.

4. **IP Configuration Issues**:
   Make sure the specified IP addresses are in the correct format (with CIDR notation) and are valid for your network.

5. **Timeouts**:
   For larger VMs or slower storage, you may need to increase the timeout values.

### Debugging

Enable Terraform logging to see more detailed information:

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log
```

## Contributing

Contributions to improve this module are welcome. Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Make your changes
4. Commit your changes (`git commit -am 'Add new feature'`)
5. Push to the branch (`git push origin feature/new-feature`)
6. Create a new Pull Request

## License

This module is available under the MIT License.

## Support

For issues, questions, or contributions, please contact:
- Issue Tracker: [Bitbucket Repository Issues](https://bitbucket.org/ginanck/proxmox_terraform/issues)
- Maintainer: [Maintainer Name](mailto:maintainer@example.com)

---

This module is not officially affiliated with Proxmox or Terraform.
