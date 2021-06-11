#!/bin/bash -xe

sudo su

apt update -y
apt install -y docker.io=$1

sed -i '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker
systemctl enable docker --now

systemctl status docker
docker --version
docker info | grep -i cgroup
