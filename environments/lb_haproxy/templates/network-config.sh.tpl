#!/bin/bash
# First boot network setup for dual NIC servers

# Wait for NetworkManager to detect interfaces
sleep 10

NET_DEVICE1=$(ip addr | awk '/^2:/ {sub(/:$/, "", $2); print $2}')
NET_DEVICE2=$(ip addr | awk '/^3:/ {sub(/:$/, "", $2); print $2}')

NET1_UUID=$(nmcli -t -f UUID,DEVICE con show | grep ":$NET_DEVICE1" | cut -d: -f1)
NET2_UUID=$(nmcli -t -f UUID,DEVICE con show | grep ":$NET_DEVICE2" | cut -d: -f1)

nmcli con modify $NET1_UUID connection.id ${ens18_iface}
nmcli con modify $NET2_UUID connection.id ${ens19_iface}

# Configure routing table and rules
grep -q "2 static_route" /etc/iproute2/rt_tables || echo "2 static_route" >> /etc/iproute2/rt_tables

nmcli con modify ${ens18_iface} \
  ipv4.method auto \
  ipv6.method auto \
  connection.autoconnect yes

nmcli con modify ${ens19_iface} \
  ipv4.method manual \
  ipv4.addresses ${ens19_ip}/${ens19_netmask} \
  ipv4.gateway ${ens19_gateway} \
  ipv4.dns "" \
  ipv4.route-metric 100 \
  connection.autoconnect yes

# Clear existing routes and routing-rules
nmcli con modify ${ens19_iface} ipv4.routes ""
nmcli con modify ${ens19_iface} ipv4.routing-rules ""

# Add static routes using numeric table ID
echo "Adding static routes..."
nmcli con modify ${ens19_iface} +ipv4.routes "${ens19_subnet} ${ens19_gateway} table=2"
nmcli con modify ${ens19_iface} +ipv4.routes "0.0.0.0/0 ${ens19_gateway} table=2"

# Add routing rules using numeric table ID
echo "Adding routing rules..."
nmcli con modify ${ens19_iface} +ipv4.routing-rules "priority 100 from ${ens19_ip} table 2"
nmcli con modify ${ens19_iface} +ipv4.routing-rules "priority 100 to ${ens19_ip} table 2"

# Apply the configurations
nmcli con up ${ens18_iface}
nmcli con up ${ens19_iface}

# Clear unused connections
UNUSED_CONN=$(nmcli -f UUID,DEVICE connection show | awk '$NF == "--" {print $1}')
nmcli connection delete $UNUSED_CONN