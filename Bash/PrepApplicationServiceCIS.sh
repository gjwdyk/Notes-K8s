#!/bin/bash -xe

echo "Executing $0"



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

# sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A
