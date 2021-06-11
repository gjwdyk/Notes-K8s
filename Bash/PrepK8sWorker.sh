#!/bin/bash -xe

sudo su

for arg in "$@"
do
 runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no $arg sudo `kubeadm token create --print-join-command`
done
