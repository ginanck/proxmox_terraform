locals {
  # Master-specific base configuration
  master_base = {
    description = "master for K8S"
    tags        = concat(local.common_config.tags, ["master"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8101
    }

    cpu         = { cores = 2 }
    memory      = { dedicated = 4096, floating = 2048 }
    disk        = { size = 40 }

    additional_disks = [
      { size = 100, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual master nodes with just the unique properties
  master_nodes = {
    "k8s-master01" = { name = "172.16.3.101-master-01", vm_id = 301, ip_address = "172.16.3.101/23" }
  }

  # Assemble the complete k8s_master configuration
  k8s_master = {
    for key, node in local.master_nodes : key => {
      name            = node.name
      vm_id           = node.vm_id
      description     = local.master_base.description
      tags            = local.master_base.tags
      clone           = local.master_base.clone
      cpu             = local.master_base.cpu
      memory          = local.master_base.memory
      disk            = local.master_base.disk
      additional_disks = local.master_base.additional_disks
      network_device  = local.master_base.network_device

      initialization = {
        dns = {
          servers = local.common_config.dns_servers
        }
        ip_config = {
          ipv4 = {
            address = node.ip_address
            gateway = local.common_config.gateway
          }
        }
        user_account = local.common_config.user_account
      }
    }
  }

  # Disk resize script
  disk_resize_script_master = <<-EOF
    #!/bin/bash
    set -e

    echo "Starting disk resize process..."

    # Wait for system to be ready
    sleep 10

    # Check current disk state
    echo "Current disk state:"
    lsblk
    df -h
    pvs

    # Resize partition 2 (LVM partition)
    echo "Resizing partition..."
    growpart /dev/vda 2

    # Resize physical volume
    echo "Resizing physical volume..."
    pvresize /dev/vda2

    # Show final state
    echo "Final disk state:"
    lsblk
    df -h
    pvs
    vgs
    lvs

    echo "Disk resize completed successfully!"
  EOF
}