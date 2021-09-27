#!/bin/bash -xe

sudo su
echo "Executing $0"

WorkerNodeStatus=/home/ubuntu/WorkerNodeStatus

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update -y

apt install -y kubeadm=1.20.7-00 kubectl=1.20.7-00 kubelet=1.20.7-00 kubernetes-cni=0.8.7-00

echo "`date +%Y%m%d%H%M%S` Worker Node Ready ." | tee -a $WorkerNodeStatus

#╔═════════╗
#║   End   ║
#╚═════════╝
