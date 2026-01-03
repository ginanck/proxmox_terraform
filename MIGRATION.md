# Migration Guide: Base Module → terraform-proxmox-vm

This document explains the migration from the legacy `base/` module to the unified `terraform-proxmox-vm` module.

## What Changed

### Module Reference
- **Before:** `source = "../../base"`
- **After:** `source = "../../../terraform-proxmox-vm"`

### Configuration Structure
- **Before:** Multiple module blocks (one per VM)
- **After:** Single module block with `vms` map

### Variable Mapping

| Old Variable | New Location | Notes |
|--------------|--------------|-------|
| `name` | `vms.{key}.name` | Inside vms map |
| `vm_id` | `vms.{key}.vm_id` | Inside vms map |
| `init_ip_address` | `vms.{key}.ip_address` | Renamed for clarity |
| `cpu_cores` | `vms.{key}.cpu_cores` or module-level default | Can be per-VM or shared |
| `memory_dedicated` | `vms.{key}.memory_dedicated` or module-level default | Can be per-VM or shared |
| `disk_size` | `vms.{key}.disk_size` or module-level default | Can be per-VM or shared |
| Common settings | Module-level (outside vms) | Applied to all VMs |

## Migration Examples

### Example 1: Single VM

**Before:**
```hcl
module "nginx" {
  source = "../../base"

  name        = "nginx-server"
  vm_id       = 281
  description = "Nginx LB"
  tags        = ["nginx"]

  cpu_cores        = 2
  memory_dedicated = 4096
  disk_size        = 40

  network_bridge  = "vmbr1"
  init_gateway    = "172.16.2.1"
  init_ip_address = "172.16.2.81/23"

  clone_vm_id = 8150
}
```

**After:**
```hcl
module "nginx" {
  source = "../../../terraform-proxmox-vm"

  vms = {
    nginx = {
      name             = "nginx-server"
      vm_id            = 281
      ip_address       = "172.16.2.81/23"
      description      = "Nginx LB"
      tags             = ["nginx"]
      cpu_cores        = 2
      memory_dedicated = 4096
      disk_size        = 40
    }
  }

  # Common settings for all VMs
  clone_vm_id      = 8150
  network_bridge   = "vmbr1"
  init_gateway     = "172.16.2.1"
  init_dns_servers = ["8.8.8.8"]
}
```

### Example 2: Multiple VMs (Jenkins)

**Before:**
```hcl
module "jenkins_master" {
  source = "../../base"

  name        = "jenkins-master"
  vm_id       = 241
  cpu_cores   = 4
  memory_dedicated = 8192
  init_ip_address = "172.16.2.41/23"
  # ... more settings
}

module "jenkins_slave_01" {
  source = "../../base"

  name        = "jenkins-slave-01"
  vm_id       = 242
  cpu_cores   = 4
  memory_dedicated = 4096
  init_ip_address = "172.16.2.42/23"
  # ... more settings
}
```

**After:**
```hcl
module "jenkins" {
  source = "../../../terraform-proxmox-vm"

  vms = {
    master = {
      name             = "jenkins-master"
      vm_id            = 241
      ip_address       = "172.16.2.41/23"
      cpu_cores        = 4
      memory_dedicated = 8192
      # ... more settings
    }
    slave01 = {
      name             = "jenkins-slave-01"
      vm_id            = 242
      ip_address       = "172.16.2.42/23"
      cpu_cores        = 4
      memory_dedicated = 4096
      # ... more settings
    }
  }

  # Common settings
  clone_vm_id    = 8150
  network_bridge = "vmbr1"
  init_gateway   = "172.16.2.1"
}
```

### Example 3: Using Locals for Dynamic VMs

**Before:**
```hcl
locals {
  workers = {
    worker01 = { vm_id = 312, ip = "172.16.3.112/23" }
    worker02 = { vm_id = 313, ip = "172.16.3.113/23" }
  }
}

module "k8s_worker" {
  source   = "../../base"
  for_each = local.workers

  name            = "k8s-${each.key}"
  vm_id           = each.value.vm_id
  init_ip_address = each.value.ip
}
```

**After:**
```hcl
locals {
  workers = {
    worker01 = { vm_id = 312, ip = "172.16.3.112/23" }
    worker02 = { vm_id = 313, ip = "172.16.3.113/23" }
  }
}

module "k8s" {
  source = "../../../terraform-proxmox-vm"

  vms = {
    for k, v in local.workers : k => {
      name       = "k8s-${k}"
      vm_id      = v.vm_id
      ip_address = v.ip
      cpu_cores  = 4
      memory_dedicated = 12288
    }
  }

  clone_vm_id    = 8053
  network_bridge = "vmbr1"
  init_gateway   = "172.16.2.1"
}
```

## Benefits of New Approach

1. **Consistency**: Same module used by both Terraform and Terragrunt repos
2. **Simplified State**: Single module call instead of multiple module instances
3. **Better Organization**: VMs grouped logically in one configuration
4. **Flexible Configuration**: Mix per-VM and shared settings
5. **Easier Maintenance**: Update module once, affects all environments

## Terraform State Considerations

⚠️ **Important:** Migrating will cause Terraform to want to destroy old resources and create new ones because the resource addresses change.

### State Migration Options

#### Option 1: Destroy and Recreate (Simplest)
```bash
terraform destroy  # Destroy old VMs
# Update configuration
terraform apply    # Create with new module
```

#### Option 2: State Move (No Downtime)
```bash
# For each VM, move state to new address
terraform state mv 'module.nginx.proxmox_virtual_environment_vm.vm' 'module.nginx.proxmox_virtual_environment_vm.vm["nginx"]'
```

#### Option 3: Import (If VMs Already Exist)
```bash
terraform import 'module.nginx.proxmox_virtual_environment_vm.vm["nginx"]' <node>/<vm_id>
```

## Validation Checklist

After migration, verify:

- [ ] All module sources point to `../../../terraform-proxmox-vm`
- [ ] No references to `../../base` remain
- [ ] `vms` map is properly structured
- [ ] Common settings moved to module level
- [ ] `init_ip_address` renamed to `ip_address`
- [ ] `terraform init` runs successfully
- [ ] `terraform plan` shows expected changes
- [ ] Provider configuration is correct

## Rollback

If needed, you can rollback by:
1. Restore old `main.tf` from git history
2. Run `terraform init` to revert module
3. Run `terraform plan` to verify

## Support

For questions or issues:
- Review module documentation: `../terraform-proxmox-vm/README.md`
- Check example configurations in `environments/`
- Compare with Terragrunt examples in `../proxmox_terragrunt/`
