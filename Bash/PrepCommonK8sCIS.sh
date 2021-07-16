#!/bin/bash -xe

sudo su

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update -y

apt install -y kubeadm=1.20.7-00 kubectl=1.20.7-00 kubelet=1.20.7-00 kubernetes-cni=0.8.7-00
