#!/bin/bash -xe

sudo su

#
# Common
#
apt install -y apt-transport-https curl

echo "@reboot   root   swapoff -a" >> /etc/crontab
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a

#
# Docker
#
echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" | tee -a /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" | tee -a /etc/sysctl.conf

echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

#
# containerd
#
printf "overlay\nbr_netfilter" >> /etc/modules-load.d/containerd.conf

echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.d/99-kubernetes-cri.conf
echo "net.bridge.bridge-nf-call-iptables=1" | tee -a /etc/sysctl.d/99-kubernetes-cri.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" | tee -a /etc/sysctl.d/99-kubernetes-cri.conf

#
# Common
#
modprobe overlay
modprobe br_netfilter

sysctl --system
sysctl --load

#
# Test
#
echo "/etc/fstab :"
cat /etc/fstab
echo "/etc/crontab :"
cat /etc/crontab

echo "/etc/sysctl.conf :"
cat /etc/sysctl.conf
echo "/proc/sys/net/bridge/bridge-nf-call-iptables :"
cat /proc/sys/net/bridge/bridge-nf-call-iptables

echo "/etc/modules-load.d/containerd.conf :"
cat /etc/modules-load.d/containerd.conf
echo "/etc/sysctl.d/99-kubernetes-cri.conf :"
cat /etc/sysctl.d/99-kubernetes-cri.conf


