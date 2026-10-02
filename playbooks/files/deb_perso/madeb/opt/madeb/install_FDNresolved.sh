#!/bin/bash
 
# 01/04/2025
# christian.pottier@univ-angers.fr
#
# installation FDNresolved DoTLS

sudo apt install -y systemd-resolved

sudo mkdir -p /etc/systemd/resolved.conf.d

echo -n "[Resolve]\n\
# dns FDN\n\
DNS=80.67.169.12#ns0.fdn.fr 2001:910:800::12#ns0.fdn.fr\n\
FallbackDNS=80.67.169.40#ns1.fdn.fr 2001:910:800::40#ns.fdn.fr\n\
DNSOverTLS=yes\n" | sudo tee /etc/systemd/resolved.conf.d/FDNresolved.conf

sudo systemctl restart systemd-resolved

resolvectl status
