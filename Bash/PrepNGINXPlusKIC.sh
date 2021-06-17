#!/bin/bash -xe

cd /home/ubuntu/kubernetes-ingress/deployments
kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f rbac/rbac.yaml
kubectl apply -f common/default-server-secret.yaml
kubectl apply -f common/nginx-config.yaml
kubectl apply -f common/ingress-class.yaml
kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
kubectl apply -f common/crds/k8s.nginx.org_policies.yaml
kubectl apply -f common/crds/k8s.nginx.org_globalconfigurations.yaml
kubectl apply -f common/global-configuration.yaml

kubectl apply -f deployment/nginx-plus-ingress.yaml
kubectl patch deployment nginx-ingress --namespace=nginx-ingress --patch '{"spec": {"template": {"spec": {"containers": [ {"name": "nginx-plus-ingress", "image": "'$1':'$2'" } ] } } } }'

kubectl create -f service/nodeport.yaml
kubectl patch service nginx-ingress --namespace=nginx-ingress --patch '{"spec": { "type": "NodePort", "ports": [ { "port": 80, "nodePort": 31080 } ] } }'
kubectl patch service nginx-ingress --namespace=nginx-ingress --patch '{"spec": { "type": "NodePort", "ports": [ { "port": 443, "nodePort": 31443 } ] } }'

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A
