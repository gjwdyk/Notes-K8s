#!/bin/bash -xe

#sudo echo "Executing $0"
#
#if [ -z "$1" ]; then
#  ContainerDVersion='1.5.5-0ubuntu3~20.04.2'
#else
#  ContainerDVersion="$1"
#fi
#
#
#
#sudo apt-get update -y && sudo apt-get install -y containerd=$ContainerDVersion
#sudo mkdir -p /etc/containerd
#sudo containerd config default | sudo tee /etc/containerd/config.toml
#sudo systemctl restart containerd
#
##╔═══════════════════╗
##║   Review Status   ║
##╚═══════════════════╝
#
#sudo systemctl status containerd --no-pager
#sudo containerd --version
#
##╔═════════╗
##║   End   ║
##╚═════════╝



sudo echo "Executing $0"

sudo apt update -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
#sudo apt install -y containerd.io=1.4.9-1 docker-ce=5:19.03.15~3-0~ubuntu-focal docker-ce-cli=5:19.03.15~3-0~ubuntu-focal
sudo apt install -y containerd.io=1.4.12-1 docker-ce=5:20.10.12~3-0~ubuntu-focal docker-ce-cli=5:20.10.12~3-0~ubuntu-focal

# sudo sed -i '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "22m",
    "max-file": "333"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker --now

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sudo systemctl status docker
sudo docker --version
sudo docker info | grep -i cgroup

#╔═════════╗
#║   End   ║
#╚═════════╝


