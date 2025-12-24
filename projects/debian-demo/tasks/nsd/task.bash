#!/bin/bash -

set -e

sudo apt-get install nsd -yq
sudo apt-get install bind9-utils -yq

sudo systemctl disable --now nsd

if [ ! -f /etc/nsd/nsd.conf.orig ]; then
    sudo cp /etc/nsd/nsd.conf /etc/nsd/nsd.conf.orig
fi


cat <<'EOF' | sudo tee /etc/nsd/nsd.conf
server:
        port: 53530
        log-only-syslog: yes
include: "/etc/nsd/nsd.conf.d/*.conf"
zone:
    name: example.com
    zonefile: /etc/nsd/example.com.zone
EOF
fi

cat<<'EOF' | sudo tee /etc/nsd/example.com.zone
$TTL    86400 ; How long should records last?
; $TTL used for all RRs without explicit TTL value
$ORIGIN example.com. ; Define our domain name
@  1D  IN  SOA ns1.example.com. hostmaster.example.com. (
                              2024061301 ; serial
                              3h ; refresh duration
                              15 ; retry duration
                              1w ; expiry duration
                              3h ; nxdomain error ttl
                             )
       IN  NS     ns1.example.com. ; in the domain
       IN  MX  10 mail.another.com. ; external mail provider
       IN  A      172.20.0.100 ; default A record
; server host definitions
ns1    IN  A      172.20.0.100 ; name server definition
www    IN  A      172.20.0.101 ; web server definition
mail   IN  A      172.20.0.102 ; mail server definition
EOF

sudo systemctl enable --now nsd

# Check nsd is enabled and running
sudo systemctl is-enabled nsd
sudo systemctl is-active nsd

# Check DNS resolution using host command
host example.com 127.0.0.1:53530

# Check individual records using dig command
dig a @127.0.0.1:53530 +short example.com
dig a @127.0.0.1:53530 +short ns1.example.com
dig a @127.0.0.1:53530 +short www.example.com
dig a @127.0.0.1:53530 +short mail.example.com
dig mx @127.0.0.1:53530 +short example.com

