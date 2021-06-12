#!/bin/bash -xe

sudo su

runuser -u ubuntu -- kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

runuser -u ubuntu -- cat <<EOF | runuser -u ubuntu -- kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

runuser -u ubuntu -- cat <<EOF | runuser -u ubuntu -- kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

runuser -u ubuntu -- kubectl patch service kubernetes-dashboard --namespace=kubernetes-dashboard --patch '{"spec": { "type": "NodePort", "ports": [ { "nodePort": 30443, "port": 443 } ] } }'
