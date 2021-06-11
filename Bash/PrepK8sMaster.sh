#!/bin/bash -xe

sudo su

kubeadm init --pod-network-cidr=$1 --service-cidr=$2

runuser -l ubuntu -c 'mkdir -p $HOME/.kube'
runuser -l ubuntu -c 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
runuser -l ubuntu -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

sleep 1m

kubectl completion bash > /etc/bash_completion.d/kubectl

runuser -u ubuntu -- kubectl apply -f $3

sleep 1m

runuser -l ubuntu -c 'kubectl get nodes --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get pods --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get services --all-namespaces -o wide --show-labels'

runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no 10.1.1.101 sudo `kubeadm token create --print-join-command`
runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no 10.1.1.102 sudo `kubeadm token create --print-join-command`
