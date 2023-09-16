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



sudo su
echo "Executing $0"

apt update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update -y
#apt install -y containerd.io=1.4.9-1 docker-ce=5:19.03.15~3-0~ubuntu-focal docker-ce-cli=5:19.03.15~3-0~ubuntu-focal
apt install -y containerd.io=1.4.12-1 docker-ce=5:20.10.12~3-0~ubuntu-focal docker-ce-cli=5:20.10.12~3-0~ubuntu-focal

# sed -i '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service
mkdir -p /etc/systemd/system/docker.service.d
tee /etc/docker/daemon.json <<EOF
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

systemctl daemon-reload
systemctl restart docker
systemctl enable docker --now

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

systemctl status docker
docker --version
docker info | grep -i cgroup

#╔═════════╗
#║   End   ║
#╚═════════╝


