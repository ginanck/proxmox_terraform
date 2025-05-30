locals {
  common_config = {
    interfaces = {
      vmbr1_ip      = "172.16.2.21/23"
      vmbr1_gateway = "172.16.2.1"
    }
    dns_servers = ["8.8.8.8", "8.8.4.4"]
    user_account = {
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmaSIzwHMrS7/nfYreiGrPfujrvABwnmODooaaIy66u ansible@gkorkmaz",
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEKPfGz+sMQ+ZwXjvgS0W4SJOoeJQA72Kx24tRW+Uf5p gkorkmaz"
      ]
      username = "ansible"
      password = "ansible"
    }
    tags = ["dev"]
  }

  technitium_config = {
    name        = "172.16.2.21-technitium"
    description = "technitium dns server for lab setup"
    vm_id       = 221
    tags        = concat(local.common_config.tags, ["technitium"])
    protection  = true

    clone = {
      datastore_id = "data"
      full         = true
      retries      = 3
      vm_id        = 8052
    }

    cpu = {
      cores      = 2
    }

    memory = {
      dedicated      = 2048
    }

    disk = {
      size = 12
    }

    additional_disks = [
      { size = 20, interface = "virtio1" }
    ]

    network_device = {
      bridge   = "vmbr1"
      model    = "virtio"
    }

    initialization = {
      dns = {
        servers = local.common_config.dns_servers
      }
      ip_config = {
        ipv4 = {
          address = local.common_config.interfaces.vmbr1_ip
          gateway = local.common_config.interfaces.vmbr1_gateway
        }
      }
      user_account = local.common_config.user_account
    }
  }

  # Improved disk resize script
  disk_resize_script = <<-EOF
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

    # Check if partition 3 can be grown
    echo "Checking if partition can be grown..."
    if growpart --dry-run /dev/vda 3 2>/dev/null; then
      echo "Partition can be grown, proceeding with resize..."
      
      # Resize partition 3 (LVM partition)
      echo "Resizing partition..."
      growpart /dev/vda 3

      # Resize physical volume
      echo "Resizing physical volume..."
      pvresize /dev/vda3
    else
      echo "Partition is already at maximum size or cannot be grown."
    fi

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
