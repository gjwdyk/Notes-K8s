#!/bin/bash -xe

sudo su

kubeadm init --pod-network-cidr=$1 --service-cidr=$2

runuser -l ubuntu -c 'mkdir -p $HOME/.kube'
runuser -l ubuntu -c 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
runuser -l ubuntu -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

kubectl apply -f $3
