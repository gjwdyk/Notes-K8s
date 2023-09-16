#!/bin/bash -xe

sudo echo "Executing $0"

if [ -z "$1" ]; then
  ContainerDVersion='1.5.5-0ubuntu3~20.04.2'
else
  ContainerDVersion="$1"
fi



sudo apt-get update -y && sudo apt-get install -y containerd=$ContainerDVersion
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sudo systemctl status containerd --no-pager
sudo containerd --version

#╔═════════╗
#║   End   ║
#╚═════════╝
