#!/bin/bash -xe

sudo su

for arg in "$@"
do
 runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no $arg sudo `kubeadm token create --print-join-command`
done

sleep 1m

runuser -l ubuntu -c 'kubectl get node --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get pod --all-namespaces -o wide --show-labels'
runuser -l ubuntu -c 'kubectl get service --all-namespaces -o wide --show-labels'
