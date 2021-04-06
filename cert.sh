#!/bin/bash
sudo certbot certonly \
  --dns-dnsimple \
  --dns-dnsimple-credentials dnsimple.ini \
  --dns-dnsimple-propagation-seconds 60 \
  -d sushilayer.com
