#!/bin/bash -xe

sudo su

echo "Executing $0"



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

# sleep 1m

runuser -l ubuntu -c 'kubectl get node --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get deployment --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get pod --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get service --all-namespaces -o wide'
