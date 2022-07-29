#!/bin/bash -xe

echo "Executing $0"

cd /home/ubuntu



kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: juiceshop
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: juiceshop
  namespace: juiceshop
spec:
  selector:
    matchLabels:
      app: juiceshop
  template:
    metadata:
      labels:
        app: juiceshop
    spec:
      containers:
      - name: juiceshop
        image: bkimminich/juice-shop:v14.1.1
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 3000
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: juiceshop
  namespace: juiceshop
  labels:
    app: juiceshop
    cis.f5.com/as3-tenant: AS3
    cis.f5.com/as3-app: K8sApplication
    cis.f5.com/as3-pool: web_pool
spec:
  selector:
    app: juiceshop
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: juiceshop-configmap
  namespace: juiceshop
  labels:
    f5type: virtual-server
    as3: "true"
data:
  template: |
    {
      "class": "AS3",
      "declaration": {
        "class": "ADC",
        "schemaVersion": "3.36.0",
        "id": "example-virtual-server-for-juiceshop",
        "label": "http",
        "remark": "A1 example",
        "AS3": {
          "class": "Tenant",
          "K8sApplication": {
            "class": "Application",
            "template": "https",
            "serviceMain": {
              "class": "Service_HTTPS",
              "virtualAddresses": [
                "10.1.1.245"
              ],
              "serverTLS": "ServiceHTTPS_TLSServer",
              "pool": "web_pool",
              "virtualPort": 443,
              "persistenceMethods": [],
              "profileHTTP": { "use": "ServiceHTTPS_HTTPProfile" },
              "ipIntelligencePolicy": { "bigip": "/Common/IP_Intelligence_Policy" },
              "profileDOS": { "bigip": "/Common/HTTP_Network_DoS_Protection_Profile" },
              "profileAnalytics": { "bigip": "/Common/HTTP_Analytics_Profile" },
              "profileAnalyticsTcp": { "bigip": "/Common/TCP_Analytics_Profile" }
            },
            "web_pool": {
              "class": "Pool",
              "monitors": [
                "http"
              ],
              "loadBalancingMode": "round-robin",
              "members": [
                {
                  "servicePort": 3000,
                  "serverAddresses": []
                }
              ]
            },
            "ServiceHTTPS_HTTPProfile": {
              "class": "HTTP_Profile",
              "otherXFF": [ "x-envoy-external-address" ],
              "trustXFF": true,
              "xForwardedFor": true
            },
            "ServiceHTTPS_TLSServer": {
              "class": "TLS_Server",
              "label": "TLS Profile for Clients to Connects to Big-IP",
              "certificates": [
                {
                  "certificate": "TLSServer_Certificate"
                }
              ]
            },
            "TLSServer_Certificate": {
              "class": "Certificate",
              "certificate": {"bigip":"/Common/HC-Imported-SSL-Key-Certificate"},
              "privateKey": {"bigip":"/Common/HC-Imported-SSL-Key-Certificate"}
            }
          }
        }
      }
    }
EOF



#╔══════════════════════════════════════════════════════════════════════╗
#║   Just a note if you want to clean up the deployments of juiceshop   ║
#╚══════════════════════════════════════════════════════════════════════╝
#
# kubectl delete --namespace juiceshop --force deployment.apps/juiceshop
# kubectl delete --namespace juiceshop --force service/juiceshop
# kubectl delete --namespace juiceshop --force configmap/juiceshop-configmap
# kubectl delete --force namespace/juiceshop



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

# sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A

#╔═════════╗
#║   End   ║
#╚═════════╝
