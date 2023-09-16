#!/bin/bash -xe

sudo echo "Executing $0"

if [ -z "$1" ]; then
  KubernetesVersion='1.23.4-00'
else
  KubernetesVersion="$1"
fi

if [ -z "$2" ]; then
  WorkerNodeStatus='/home/ubuntu/WorkerNodeStatus'
else
  WorkerNodeStatus="$2"
fi



sudo curl -k -L --retry 333 https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo tee /etc/apt/sources.list.d/kubernetes.list << EOF
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y && sudo apt-get install -y kubelet=$KubernetesVersion kubeadm=$KubernetesVersion kubectl=$KubernetesVersion
# sudo apt-mark hold kubelet kubeadm kubectl

echo "`date +%Y%m%d%H%M%S` Worker Node Ready ." | tee $WorkerNodeStatus

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sudo kubeadm version
sudo kubectl version --client
sudo kubelet --version

#╔═════════╗
#║   End   ║
#╚═════════╝
