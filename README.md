# Proxmox Terraform Configurations

This repository contains Terraform configurations for managing Proxmox VMs using the [terraform-proxmox-vm](../terraform-proxmox-vm) module.

## Architecture

All environments now use the unified `terraform-proxmox-vm` module which supports:
- Multi-VM deployment via `vms` map
- Windows and Linux support
- WinRM provisioning for Windows
- Cloud-init support
- Flexible per-VM and common configuration

## Structure

```
proxmox_terraform/
├── base/                    # Legacy base module (deprecated)
├── environments/            # Environment-specific configurations
│   ├── harbor/             # Docker registry
│   ├── jenkins/            # CI/CD infrastructure (master + slaves)
│   ├── kubernetes/         # K8S cluster (masters + workers)
│   ├── nfs/                # NFS storage server
│   ├── nginx/              # Load balancer
│   ├── posteio/            # Email server
│   ├── smallstep/          # Certificate authority
│   ├── technitium/         # DNS server
│   ├── training_aanbar_vm/ # Training environment
│   ├── training_experimental/ # Experimental setup
│   └── windows-example/    # Windows VM example
└── README.md
```

## Usage

### Prerequisites

1. Terraform >= 1.0.0
2. Proxmox credentials configured
3. terraform-proxmox-vm module available at `../terraform-proxmox-vm`

### Basic Workflow

```bash
cd environments/<environment-name>
terraform init
terraform plan
terraform apply
```

### Module Source Options

The `terraform-proxmox-vm` module can be referenced in multiple ways:

**Local Path (Relative):**
```hcl
module "nginx" {
  source = "../../../terraform-proxmox-vm"
  # ... configuration
}
```

**Git via HTTPS:**
```hcl
module "nginx" {
  source = "git::https://github.com/ginanck/terraform-proxmox-vm.git?ref=master"
  # ... configuration
}
```

**Git via SSH:**
```hcl
module "nginx" {
  source = "git::ssh://git@github.com/ginanck/terraform-proxmox-vm.git?ref=master"
  # ... configuration
}
```

### Example: Single VM Deployment

See [nginx/main.tf](environments/nginx/main.tf):

```hcl
module "nginx" {
  source = "git::https://github.com/ginanck/terraform-proxmox-vm.git?ref=master"

  vms = {
    nginx = {
      name       = "nginx-server"
      vm_id      = 281
      ip_address = "172.16.2.81/23"
      cpu_cores  = 2
      memory_dedicated = 4096
      disk_size  = 40
    }
  }

  clone_vm_id    = 8150
  network_bridge = "vmbr1"
  init_gateway   = "172.16.2.1"
}
```

### Example: Multi-VM Deployment

See [jenkins/main.tf](environments/jenkins/main.tf) for master + slaves configuration.

## Migration from Base Module

All environments have been migrated from the legacy `base/` module to use `terraform-proxmox-vm`. The new approach:

**Before (deprecated):**
```hcl
module "vm1" {
  source = "../../base"
  name   = "vm1"
  vm_id  = 100
}

module "vm2" {
  source = "../../base"
  name   = "vm2"
  vm_id  = 101
}
```

**After (current):**
```hcl
module "vms" {
  source = "../../../terraform-proxmox-vm"

  vms = {
    vm1 = { name = "vm1", vm_id = 100, ip_address = "..." }
    vm2 = { name = "vm2", vm_id = 101, ip_address = "..." }
  }
}
```

## Environments Overview

| Environment | Purpose | VMs | Special Features |
|-------------|---------|-----|------------------|
| harbor | Docker Registry | 1 | Large storage disk |
| jenkins | CI/CD | 3 (1 master, 2 slaves) | Multi-VM deployment |
| kubernetes | Container Orchestration | 3 (1 master, 2 workers) | Different clone templates |
| nfs | Network Storage | 1 | Large data disk |
| nginx | Load Balancer | 1 | K8S ingress |
| posteio | Email Server | 1 | Public IP |
| smallstep | CA | 1 | Security services |
| technitium | DNS Server | 1 | Additional disk |
| windows-example | Windows Demo | 1 | OVMF BIOS, WinRM |

## Module Reference

For full module documentation, see [terraform-proxmox-vm/README.md](../terraform-proxmox-vm/README.md).

## Notes

- The `base/` directory is now deprecated and maintained only for reference
- All new environments should use the `terraform-proxmox-vm` module
- This aligns with the Terragrunt repository structure
