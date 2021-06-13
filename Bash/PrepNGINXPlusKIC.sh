#!/bin/bash -xe

sudo su

cd /home/ubuntu/kubernetes-ingress/deployments
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

runuser -u ubuntu -- cat <<EOF | runuser -u ubuntu -- kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress
  namespace: nginx-ingress
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-ingress
  template:
    metadata:
      labels:
        app: nginx-ingress
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9113"
    spec:
      serviceAccountName: nginx-ingress
      containers:
      - image: $3:1.11.3
        imagePullPolicy: IfNotPresent
        name: nginx-plus-ingress
        ports:
        - name: http
          containerPort: 80
        - name: https
          containerPort: 443
        - name: readiness-port
          containerPort: 8081
        - name: prometheus
          containerPort: 9113
        readinessProbe:
          httpGet:
            path: /nginx-ready
            port: readiness-port
          periodSeconds: 1
        securityContext:
          allowPrivilegeEscalation: true
          runAsUser: 101 #nginx
          capabilities:
            drop:
            - ALL
            add:
            - NET_BIND_SERVICE
        env:
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        args:
          - -nginx-plus
          - -nginx-configmaps=$(POD_NAMESPACE)/nginx-config
          - -default-server-tls-secret=$(POD_NAMESPACE)/default-server-secret
         #- -enable-app-protect
          - -v=3 # Enables extensive logging. Useful for troubleshooting.
          - -report-ingress-status
          - -external-service=nginx-ingress
          - -enable-prometheus-metrics
          - -global-configuration=$(POD_NAMESPACE)/nginx-configuration
EOF

runuser -u ubuntu -- cat <<EOF | runuser -u ubuntu -- kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-ingress
  namespace: nginx-ingress
spec:
  type: NodePort 
  ports:
  - name: http
    port: 80
    targetPort: 80
    nodePort: 31080
    protocol: TCP
  - name: https
    port: 443
    targetPort: 443
    nodePort: 31443
    protocol: TCP
  selector:
    app: nginx-ingress
EOF

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

runuser -l ubuntu -c 'kubectl get node --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get deployment --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get pod --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get service --all-namespaces -o wide'
