#!/bin/bash -xe

sudo su
echo "Executing $0"

apt update -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update -y
#apt install -y containerd.io=1.4.12-1 docker-ce=5:20.10.12~3-0~ubuntu-focal docker-ce-cli=5:20.10.12~3-0~ubuntu-focal
apt install -y containerd.io=1.6.22-1 docker-ce=5:24.0.6-1~ubuntu.20.04~focal docker-ce-cli=5:24.0.6-1~ubuntu.20.04~focal

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
