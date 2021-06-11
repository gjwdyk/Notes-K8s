#!/bin/bash -xe

sudo su

kubeadm init --pod-network-cidr=$1 --service-cidr=$2

runuser -l ubuntu -c 'mkdir -p $HOME/.kube'
runuser -l ubuntu -c 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
runuser -l ubuntu -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

kubectl apply -f $3

kubectl completion bash > /etc/bash_completion.d/kubectl

kubectl get nodes --all-namespaces -o wide --show-labels
kubectl get pods --all-namespaces -o wide --show-labels
kubectl get services --all-namespaces -o wide --show-labels
