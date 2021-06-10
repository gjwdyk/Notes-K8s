#!/bin/bash -xe

sudo su

echo "@reboot   root   swapoff -a" >> /etc/crontab
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a

echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" | tee -a /etc/sysctl.conf
modprobe overlay
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl --system
sysctl --load

apt update -y
