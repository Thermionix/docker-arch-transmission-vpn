#!/bin/bash

# iptables -A OUTPUT -m owner --uid-owner transmission -d 192.168.1.0/24 -j ACCEPT
# iptables -A OUTPUT -m owner --uid-owner transmission \! -o tun0 -j REJECT

#iptables -A OUTPUT -d 10.0.0.0/8 -p tcp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT
#iptables -A OUTPUT -d 10.0.0.0/8 -p udp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT
#iptables -A OUTPUT -m owner --gid-owner transmission -o tun0 -j ACCEPT
#iptables -A OUTPUT -m owner --gid-owner transmission -o lo -j ACCEPT
#iptables -A OUTPUT -m owner --gid-owner transmission -j REJECT

iptables -A OUTPUT -d 192.168.0.0/16 -p tcp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.0/16 -p udp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT

iptables -A OUTPUT -d 172.16.0.0/12 -p tcp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT
iptables -A OUTPUT -d 172.16.0.0/12 -p udp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT

iptables -A OUTPUT -d 10.0.0.0/8 -p tcp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT
iptables -A OUTPUT -d 10.0.0.0/8 -p udp --sport 9091 -m owner --gid-owner transmission -o eth0 -j ACCEPT

iptables -A OUTPUT -m owner --gid-owner transmission -o tun0 -j ACCEPT
iptables -A OUTPUT -m owner --gid-owner transmission -o lo -j ACCEPT
iptables -A OUTPUT -m owner --gid-owner transmission -j REJECT

# 192.168.0.0/16
# 172.16.0.0/12
# 10.0.0.0/8
