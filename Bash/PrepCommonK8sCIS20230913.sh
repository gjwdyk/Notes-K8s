#!/bin/bash -xe

sudo su
echo "Executing $0"

WorkerNodeStatus=/home/ubuntu/WorkerNodeStatus

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update -y

apt install -y kubeadm=1.28.1-00 kubectl=1.28.1-00 kubelet=1.28.1-00 kubernetes-cni=1.2.0-00

echo "`date +%Y%m%d%H%M%S` Worker Node Ready ." | tee -a $WorkerNodeStatus

#╔═════════╗
#║   End   ║
#╚═════════╝
