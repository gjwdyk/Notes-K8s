#!/bin/bash -xe

sudo su

cd ~/kubernetes-ingress/deployments
runuser -u ubuntu -- kubectl apply -f common/ns-and-sa.yaml
runuser -u ubuntu -- kubectl apply -f rbac/rbac.yaml
runuser -u ubuntu -- kubectl apply -f common/default-server-secret.yaml
runuser -u ubuntu -- kubectl apply -f common/nginx-config.yaml
runuser -u ubuntu -- kubectl apply -f common/ingress-class.yaml
runuser -u ubuntu -- kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
runuser -u ubuntu -- kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
runuser -u ubuntu -- kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
runuser -u ubuntu -- kubectl apply -f common/crds/k8s.nginx.org_policies.yaml
runuser -u ubuntu -- kubectl apply -f common/crds/k8s.nginx.org_globalconfigurations.yaml
runuser -u ubuntu -- kubectl apply -f common/global-configuration.yaml
