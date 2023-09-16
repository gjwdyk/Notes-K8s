#!/bin/bash -xe

sudo echo "Executing $0"



sudo apt-get update -y && sudo apt-get install -y apt-transport-https curl

sudo echo "@reboot   root   swapoff -a" | sudo tee -a /etc/crontab
# sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo echo "net.bridge.bridge-nf-call-ip6tables=1" | sudo tee -a /etc/sysctl.conf
# sudo echo '1' | sudo tee /proc/sys/net/bridge/bridge-nf-call-iptables

sudo printf "overlay\nbr_netfilter" | sudo tee -a /etc/modules-load.d/containerd.conf
sudo modprobe overlay
sudo modprobe br_netfilter

sudo sysctl --system
sudo sysctl --load

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sudo echo "/etc/fstab :"
sudo cat /etc/fstab
sudo echo "/etc/crontab :"
sudo cat /etc/crontab

sudo echo "/etc/sysctl.conf :"
sudo cat /etc/sysctl.conf
sudo echo "/proc/sys/net/bridge/bridge-nf-call-iptables :"
sudo cat /proc/sys/net/bridge/bridge-nf-call-iptables

sudo echo "/etc/modules-load.d/containerd.conf :"
sudo cat /etc/modules-load.d/containerd.conf

#╔═════════╗
#║   End   ║
#╚═════════╝
