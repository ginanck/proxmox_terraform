# Proxmox Virtual Machine Base Module

A Terraform module for provisioning Virtual Machines in Proxmox VE with comprehensive configuration options. This module provides all the necessary variables as individual inputs, making it easy to customize VM configurations while maintaining sensible defaults.

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

This module uses the `bpg/proxmox` provider. Configure the provider in your root module:

```hcl
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
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

```hcl
module "proxmox_vm" {
  source = "../../base"  # Path to this base module

  name        = "web-server"
  description = "Web Server VM"
  node_name   = "proxmox-node1"
  vm_id       = 120
  
  # CPU and Memory
  cpu_cores        = 2
  memory_dedicated = 4096
  
  # Network
  init_ip_address = "192.168.1.100/24"
  init_gateway    = "192.168.1.1"
}
```

## Input Variables

This module provides individual variables for all VM configuration options. Each variable has a sensible default value defined in `variables.tf`.

### Basic VM Settings

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `name` | VM name | `string` | `"vm-test1"` |
| `description` | VM description | `string` | `"Test VM managed by Terraform"` |
| `node_name` | Proxmox node name where the VM will be created | `string` | `"carbon"` |
| `vm_id` | VM ID (must be unique across the Proxmox cluster) | `number` | `110` |
| `tags` | List of tags to apply to the VM | `list(string)` | `["test", "test-vm-base"]` |

### VM Behavior Settings

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `acpi` | Enable ACPI support | `bool` | `true` |
| `agent_enabled` | Enable QEMU guest agent | `bool` | `true` |
| `bios` | BIOS type (seabios or ovmf) | `string` | `"seabios"` |
| `keyboard_layout` | Keyboard layout | `string` | `"en-us"` |
| `migrate` | Enable live migration | `bool` | `false` |
| `on_boot` | Start VM on node boot | `bool` | `true` |
| `protection` | Enable VM protection (prevents accidental deletion) | `bool` | `false` |
| `reboot` | Reboot VM after creation | `bool` | `false` |
| `reboot_after_update` | Reboot VM after updates | `bool` | `true` |
| `started` | Start VM after creation | `bool` | `true` |
| `stop_on_destroy` | Stop VM before destroying | `bool` | `false` |
| `tablet_device` | Enable tablet device for better mouse handling | `bool` | `true` |
| `template` | Create as template | `bool` | `false` |
| `scsi_hardware` | SCSI hardware type | `string` | `"virtio-scsi-pci"` |

### Timeout Settings

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `timeout_clone` | Timeout for clone operations (seconds) | `number` | `1800` |
| `timeout_create` | Timeout for create operations (seconds) | `number` | `1800` |
| `timeout_migrate` | Timeout for migrate operations (seconds) | `number` | `1800` |
| `timeout_reboot` | Timeout for reboot operations (seconds) | `number` | `1800` |
| `timeout_shutdown_vm` | Timeout for shutdown operations (seconds) | `number` | `1800` |
| `timeout_start_vm` | Timeout for start operations (seconds) | `number` | `1800` |
| `timeout_stop_vm` | Timeout for stop operations (seconds) | `number` | `300` |

### Clone Settings

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `clone_vm_id` | VM ID of the template to clone from | `number` | `8052` |
| `clone_datastore_id` | Datastore ID for clone operation | `string` | `"data"` |
| `clone_full` | Perform full clone instead of linked clone | `bool` | `true` |
| `clone_retries` | Number of clone retries | `number` | `3` |

### CPU Configuration

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `cpu_cores` | Number of CPU cores | `number` | `1` |
| `cpu_sockets` | Number of CPU sockets | `number` | `1` |
| `cpu_type` | CPU type | `string` | `"host"` |
| `cpu_units` | CPU weight (relative to other VMs) | `number` | `1024` |
| `cpu_limit` | CPU limit (0 = unlimited) | `number` | `0` |
| `cpu_numa` | Enable NUMA | `bool` | `false` |
| `cpu_hotplugged` | Number of hotplugged CPU cores | `number` | `0` |

### Memory Configuration

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `memory_dedicated` | Dedicated memory in MB | `number` | `2048` |
| `memory_floating` | Floating memory in MB | `number` | `0` |
| `memory_shared` | Shared memory in MB | `number` | `0` |
| `memory_keep_hugepages` | Keep hugepages after VM shutdown | `bool` | `false` |

### Primary Disk Configuration

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `disk_size` | Primary disk size in GB | `number` | `10` |
| `disk_datastore_id` | Datastore ID for primary disk | `string` | `"data"` |
| `disk_interface` | Disk interface (virtio0, scsi0, etc.) | `string` | `"virtio0"` |
| `disk_file_format` | Disk file format (raw, qcow2, vmdk) | `string` | `"qcow2"` |
| `disk_cache` | Disk cache mode | `string` | `"none"` |
| `disk_aio` | AIO mode | `string` | `"io_uring"` |
| `disk_backup` | Include disk in backups | `bool` | `false` |
| `disk_discard` | Discard mode (ignore, on) | `string` | `"ignore"` |
| `disk_iothread` | Enable IO thread | `bool` | `false` |
| `disk_replicate` | Enable replication | `bool` | `false` |
| `disk_ssd` | Mark disk as SSD | `bool` | `false` |

### Additional Disks (Optional)

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `additional_disks` | List of additional disks to attach to the VM | `list(object)` | `[]` |

Each object in `additional_disks` supports the same parameters as the primary disk configuration.

### Primary Network Device

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `network_bridge` | Network bridge for primary network device | `string` | `"vmbr0"` |
| `network_model` | Network model (virtio, e1000, rtl8139) | `string` | `"virtio"` |
| `network_enabled` | Enable primary network device | `bool` | `true` |
| `network_firewall` | Enable firewall for primary network device | `bool` | `false` |
| `network_mac_address` | MAC address for primary network device | `string` | `null` |
| `network_mtu` | MTU for primary network device (0 = default) | `number` | `0` |
| `network_queues` | Number of packet queues (0 = default) | `number` | `0` |
| `network_rate_limit` | Rate limit in MB/s (0 = unlimited) | `number` | `0` |
| `network_vlan_id` | VLAN ID (0 = no VLAN) | `number` | `0` |

### Additional Network Devices (Optional)

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `additional_network_devices` | List of additional network devices | `list(object)` | `[]` |

### Cloud-Init Configuration

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `init_datastore_id` | Datastore ID for cloud-init drive | `string` | `"data"` |
| `init_interface` | Interface for cloud-init drive | `string` | `"scsi0"` |
| `init_dns_servers` | List of DNS servers | `list(string)` | `["8.8.8.8", "8.8.4.4"]` |
| `init_ip_address` | Primary IP address with CIDR | `string` | `"172.16.2.100/24"` |
| `init_gateway` | Default gateway IP address | `string` | `"172.16.2.1"` |
| `init_username` | Default user account username | `string` | `"ansible"` |
| `init_password` | Default user account password | `string` | `"ansible"` |
| `init_ssh_keys` | List of SSH public keys for default user | `list(string)` | See variables.tf |

### Additional IP Configurations (Optional)

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `additional_ip_configs` | List of additional IP configurations | `list(object)` | `[]` |

## Outputs

| Output Name | Description |
|-------------|-------------|
| `vm_id`     | The ID of the created VM |
| `vm_name`   | The name of the created VM |
| `vm_ip`     | The primary IP address of the created VM |

Example usage:

```hcl
output "vm_details" {
  value = {
    id   = module.my_vm.vm_id
    name = module.my_vm.vm_name
    ip   = module.my_vm.vm_ip
  }
}
```

## Examples

### Example 1: Basic Web Server

A simple web server VM with minimal configuration:

```hcl
module "web_server" {
  source = "../../base"

  # Basic VM settings
  name        = "web-server-01"
  description = "Production Web Server"
  node_name   = "proxmox-node1"
  vm_id       = 200
  tags        = ["web", "production"]

  # Hardware configuration
  cpu_cores        = 2
  memory_dedicated = 4096
  disk_size        = 20

  # Network configuration  
  network_bridge = "vmbr0"
  
  # Cloud-init configuration
  init_ip_address = "192.168.1.100/24"
  init_gateway    = "192.168.1.1"
  init_dns_servers = ["192.168.1.1", "8.8.8.8"]
  init_username   = "webadmin"
  init_password   = "secure-password"
  init_ssh_keys   = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u admin@company.com"
  ]

  # Clone from template
  clone_vm_id = 9000
}
```

### Example 2: Database Server with Additional Storage

A more complex database server with multiple disks and network interfaces:

```hcl
module "db_server" {
  source = "../../base"

  # Basic VM settings
  name        = "db-server-01"
  description = "PostgreSQL Database Server"
  node_name   = "proxmox-node2" 
  vm_id       = 300
  tags        = ["database", "postgresql", "production"]

  # Enhanced hardware configuration
  cpu_cores        = 4
  cpu_type         = "host"
  memory_dedicated = 8192
  
  # Primary disk (OS)
  disk_size         = 40
  disk_datastore_id = "ssd-pool"
  disk_ssd          = true
  disk_backup       = true

  # Additional storage for database
  additional_disks = [
    {
      interface    = "virtio1"
      size         = 100
      datastore_id = "ssd-pool" 
      ssd          = true
      backup       = true
    },
    {
      interface    = "virtio2"
      size         = 200
      datastore_id = "hdd-pool"
      backup       = true
    }
  ]

  # Primary network (management)
  network_bridge     = "vmbr0"
  network_vlan_id    = 100
  
  # Additional network for database traffic
  additional_network_devices = [
    {
      bridge  = "vmbr1"
      vlan_id = 200
    }
  ]

  # Network configuration
  init_ip_address = "10.0.100.50/24"
  init_gateway    = "10.0.100.1"
  init_dns_servers = ["10.0.100.10", "10.0.100.11"]
  
  # Additional IP for database network
  additional_ip_configs = [
    {
      address = "10.0.200.50/24"
      gateway = "10.0.200.1"
    }
  ]

  # User configuration
  init_username = "dbadmin"
  init_password = "very-secure-password"
  init_ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u dba@company.com",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC... backup-key@company.com"
  ]

  # Clone settings
  clone_vm_id        = 9001  # Database template
  clone_datastore_id = "ssd-pool"
  clone_full         = true

  # VM behavior
  on_boot     = true
  protection  = true
  started     = true
}
```

## Example 2: Multiple VMs

Create multiple VMs using `for_each`:

```hcl
locals {
  web_servers = {
    web1 = {
      vm_id = 201
      ip    = "192.168.1.101/24"
    }
    web2 = {
      vm_id = 202  
      ip    = "192.168.1.102/24"
    }
  }
}

module "web_servers" {
  source   = "./base"
  for_each = local.web_servers
  
  name                = "web-server-${each.key}"
  description         = "Web Server ${each.key}"
  vm_id              = each.value.vm_id
  node_name          = "proxmox-node1"
  
  cpu_cores          = 2
  memory_dedicated   = 4096
  disk_size          = 20
  
  init_ip_address    = each.value.ip
  init_gateway       = "192.168.1.1"
  
  clone_vm_id        = 9000
  tags               = ["web", "production"]
}

output "web_server_ips" {
  value = {
    for k, v in module.web_servers : k => v.vm_ip
  }
}
```

## Troubleshooting

### Common Issues

- **Authentication**: Verify Proxmox API credentials and permissions
- **VM ID conflicts**: Ensure unique VM IDs across the cluster  
- **Clone failures**: Verify source template exists and is accessible
- **IP conflicts**: Use proper CIDR notation and ensure IPs are available
- **Timeouts**: Increase timeout values for larger VMs or slower storage

### Debug Mode

Enable Terraform debug logging:

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log
terraform plan
```

## Requirements

- Terraform >= 1.0
- Proxmox VE 7.0+
- bpg/proxmox provider ~> 0.73.0

## License

MIT License
