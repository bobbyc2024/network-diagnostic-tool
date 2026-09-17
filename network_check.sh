#!/bin/bash

echo "Network Diagnostic Tool"
echo "-----------------------"

echo ""
echo "Local IP Address:"
ipconfig getifaddr en0

echo ""
echo "Default Gateway:"
route -n get default | grep gateway

echo ""
echo "Internet Connectivity:"

if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo "Internet: PASS"
else
    echo "Internet: FAIL"
fi

echo ""
echo "DNS Resolution:"
nslookup google.com

echo ""
echo "VPN Status:"

default_interface=$(route -n get default | grep interface | awk '{print $2}')

if [[ "$default_interface" == utun* ]]; then
    echo "VPN: ON"
    echo "VPN Interface: $default_interface"
else
    echo "VPN: OFF"
    echo "Default Interface: $default_interface"
fi