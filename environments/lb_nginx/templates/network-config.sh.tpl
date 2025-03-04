#!/bin/bash

rm -rf /etc/netplan/*.yaml

# Configure first network interface
cat > /etc/netplan/80-my.yaml << EOF
network:
  version: 2
  ethernets:
    ${ens18_iface}:
      dhcp4: true
      match:
        macaddress: ${ens18_mac}
      set-name: ${ens18_iface_new}
    ${ens19_iface}:
      dhcp4: false
      addresses:
        - ${ens19_ip}/${ens19_netmask}
      routes:
        - to: default
          via: ${ens19_gateway}
        - to: ${ens19_ip}/${ens19_netmask}
          via: ${ens19_gateway}
      nameservers:
        addresses: [${dns_servers}]
EOF

chmod 600 /etc/netplan/80-my.yaml

netplan apply

echo "Configuration completed successfully"