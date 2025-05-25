locals {
  # Worker-specific base configuration
  worker_base = {
    description = "worker for K8S"
    tags        = concat(local.common_config.tags, ["worker"])

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8052
    }

    cpu         = { cores = 4 }
    memory      = { dedicated = 4096, floating = 2048 }
    disk        = { size = 40 }

    additional_disks = [
      { size = 150, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }
  }

  # Define the individual worker nodes
  worker_nodes = {
    "k8s-worker01" = { name = "172.16.3.111-worker-01", vm_id = 311, ip_address = "172.16.3.111/23" }
  }

  # Assemble the complete k8s_worker configuration
  k8s_worker = {
    for key, node in local.worker_nodes : key => {
      name             = node.name
      vm_id            = node.vm_id
      description      = local.worker_base.description
      tags             = local.worker_base.tags
      clone            = local.worker_base.clone
      cpu              = local.worker_base.cpu
      memory           = local.worker_base.memory
      disk             = local.worker_base.disk
      additional_disks = local.worker_base.additional_disks
      network_device   = local.worker_base.network_device

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
  disk_resize_script_worker = <<-EOF
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

    # Resize partition 3 (LVM partition)
    echo "Resizing partition..."
    growpart /dev/vda 3

    # Resize physical volume
    echo "Resizing physical volume..."
    pvresize /dev/vda3

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