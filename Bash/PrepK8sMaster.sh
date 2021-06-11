#!/bin/bash -xe

sudo su

kubeadm init --pod-network-cidr=$1 --service-cidr=$2

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
