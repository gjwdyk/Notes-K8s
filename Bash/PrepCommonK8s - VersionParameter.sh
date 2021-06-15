#!/bin/bash -xe

sudo su

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update -y

apt install -y kubeadm=$1 kubectl=$2 kubelet=$3 kubernetes-cni=$4
