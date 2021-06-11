#!/bin/bash -xe

sudo su

for arg in "$@"
do
 runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no $arg sudo `kubeadm token create --print-join-command`
done

sleep 1m

runuser -l ubuntu -c 'kubectl get nodes --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get pods --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get services --all-namespaces -o wide --show-labels'
