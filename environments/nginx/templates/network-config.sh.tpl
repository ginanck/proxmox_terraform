#!/bin/bash
# First boot network setup for dual NIC servers

# Wait for NetworkManager to detect interfaces
sleep 10

# Clear unused connections
UNUSED_CONN=$(nmcli -f UUID,DEVICE connection show | awk '$NF == "--" {print $1}')
nmcli connection delete $UNUSED_CONN

# Rename connections on interfaces
NET_DEVICE1=$(ip addr | awk '/^2:/ {sub(/:$/, "", $2); print $2}')
NET_DEVICE2=$(ip addr | awk '/^3:/ {sub(/:$/, "", $2); print $2}')

NET1_UUID=$(nmcli -t -f UUID,DEVICE con show | grep ":$NET_DEVICE1" | cut -d: -f1)
NET2_UUID=$(nmcli -t -f UUID,DEVICE con show | grep ":$NET_DEVICE2" | cut -d: -f1)

nmcli con modify $NET1_UUID connection.id ${ens18_iface}
nmcli con modify $NET2_UUID connection.id ${ens19_iface}

# let's fix the rp_filter setting
sysctl -w net.ipv4.conf.all.rp_filter=2
sysctl -w net.ipv4.conf.eth0.rp_filter=2
sysctl -w net.ipv4.conf.ens19.rp_filter=2
echo "net.ipv4.conf.all.rp_filter=2" >> /etc/sysctl.d/99-routing.conf
echo "net.ipv4.conf.default.rp_filter=2" >> /etc/sysctl.d/99-routing.conf

# Set up proper policy-based routing, create routing tables
echo "1 eth0_table" >> /etc/iproute2/rt_tables
echo "2 ens19_table" >> /etc/iproute2/rt_tables

# Configure eth0 (public)
nmcli con modify ${ens18_iface} \
  ipv4.method auto \
  ipv4.route-metric 10 \
  connection.autoconnect yes

# Configure ens19 (private)
nmcli con modify ${ens19_iface} \
  connection.id ${ens19_iface} \
  ipv4.method manual \
  ipv4.addresses ${ens19_ip}/${ens19_netmask} \
  ipv4.gateway ${ens19_gateway} \
  ipv4.route-metric 100 \
  connection.autoconnect yes

# Clear existing routing rules on the interfaces
nmcli con modify ${ens18_iface} ipv4.routing-rules ""
nmcli con modify ${ens19_iface} ipv4.routing-rules ""

# Add routing rules for source-based routing
nmcli con modify ${ens18_iface} +ipv4.routing-rules "priority 100 from ${ens18_ip} table 1"
nmcli con modify ${ens19_iface} +ipv4.routing-rules "priority 100 from ${ens19_ip} table 2"

# Configure per-table routes for eth0
nmcli con modify ${ens18_iface} +ipv4.routes "65.109.108.128/26 65.109.108.129 table=1"
nmcli con modify ${ens18_iface} +ipv4.routes "0.0.0.0/0 65.109.108.129 table=1"

# Configure per-table routes for ens19
nmcli con modify ${ens19_iface} +ipv4.routes "${ens19_subnet} ${ens19_gateway} table=2"
nmcli con modify ${ens19_iface} +ipv4.routes "0.0.0.0/0 ${ens19_gateway} table=2"

# Apply the configurations
nmcli con down ${ens18_iface} && nmcli con up ${ens18_iface}
nmcli con down ${ens19_iface} && nmcli con up ${ens19_iface}
