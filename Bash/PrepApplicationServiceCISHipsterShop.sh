#!/bin/bash -xe

echo "Executing $0"

cd /home/ubuntu



kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: hipstershop
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: emailservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: emailservice
  template:
    metadata:
      labels:
        app: emailservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/emailservice:v0.1.2
        ports:
        - containerPort: 8080
        env:
        - name: PORT
          value: "8080"
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        livenessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        env:
        - name: ENABLE_PROFILER
          value: "0"
---
apiVersion: v1
kind: Service
metadata:
  name: emailservice
  namespace: hipstershop
  labels:
    app: emailservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: emailservice
  ports:
  - name: grpc
    port: 5000
    targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: paymentservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: paymentservice
  template:
    metadata:
      labels:
        app: paymentservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/paymentservice:v0.1.2
        ports:
        - containerPort: 50051
        env:
        - name: PORT
          value: "50051"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
---
apiVersion: v1
kind: Service
metadata:
  name: paymentservice
  namespace: hipstershop
  labels:
    app: paymentservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: paymentservice
  ports:
  - name: grpc
    port: 50051
    targetPort: 50051
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: productcatalogservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: productcatalogservice
  template:
    metadata:
      labels:
        app: productcatalogservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/productcatalogservice:v0.1.2
        ports:
        - containerPort: 3550
        env:
        - name: PORT
          value: "3550"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:3550"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:3550"]
---
apiVersion: v1
kind: Service
metadata:
  name: productcatalogservice
  namespace: hipstershop
  labels:
    app: productcatalogservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: productcatalogservice
  ports:
  - name: grpc
    port: 3550
    targetPort: 3550
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cartservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: cartservice
  template:
    metadata:
      labels:
        app: cartservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/solutions-team-280017/cartservice:latest
        ports:
        - containerPort: 7070
        env:
        - name: REDIS_ADDR
          value: "redis-cart:6379"
        - name: PORT
          value: "7070"
        - name: LISTEN_ADDR
          value: "0.0.0.0"
        readinessProbe:
          initialDelaySeconds: 15
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
        livenessProbe:
          initialDelaySeconds: 15
          periodSeconds: 10
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7070", "-rpc-timeout=5s"]
---
apiVersion: v1
kind: Service
metadata:
  name: cartservice
  namespace: hipstershop
  labels:
    app: cartservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: cartservice
  ports:
  - name: grpc
    port: 7070
    targetPort: 7070
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: currencyservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: currencyservice
  template:
    metadata:
      labels:
        app: currencyservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/currencyservice:v0.1.2
        ports:
        - name: grpc
          containerPort: 7000
        env:
        - name: PORT
          value: "7000"
        readinessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7000"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:7000"]
---
apiVersion: v1
kind: Service
metadata:
  name: currencyservice
  namespace: hipstershop
  labels:
    app: currencyservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: currencyservice
  ports:
  - name: grpc
    port: 7000
    targetPort: 7000
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shippingservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: shippingservice
  template:
    metadata:
      labels:
        app: shippingservice
    spec:
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/shippingservice:v0.1.2
        ports:
        - containerPort: 50051
        env:
        - name: PORT
          value: "50051"
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
        livenessProbe:
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:50051"]
---
apiVersion: v1
kind: Service
metadata:
  name: shippingservice
  namespace: hipstershop
  labels:
    app: shippingservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: shippingservice
  ports:
  - name: grpc
    port: 50051
    targetPort: 50051
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recommendationservice
  namespace: hipstershop
  annotations:
    ves.io/workload-flavor: medium
spec:
  selector:
    matchLabels:
      app: recommendationservice
  template:
    metadata:
      labels:
        app: recommendationservice
    spec:
      terminationGracePeriodSeconds: 5
      containers:
      - name: server
        image: gcr.io/google-samples/microservices-demo/recommendationservice:v0.1.2
        ports:
        - containerPort: 8080
        readinessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        livenessProbe:
          periodSeconds: 5
          exec:
            command: ["/bin/grpc_health_probe", "-addr=:8080"]
        env:
        - name: PORT
          value: "8080"
        - name: PRODUCT_CATALOG_SERVICE_ADDR
          value: "productcatalogservice:3550"
        - name: ENABLE_PROFILER
          value: "0"
---
apiVersion: v1
kind: Service
metadata:
  name: recommendationservice
  namespace: hipstershop
  labels:
    app: recommendationservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  ports:
    - name: grpc
      protocol: TCP
      port: 8089
      targetPort: 8080
  selector:
    app: recommendationservice
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: checkoutservice
  namespace: hipstershop
spec:
  selector:
    matchLabels:
      app: checkoutservice
  template:
    metadata:
      labels:
        app: checkoutservice
    spec:
      containers:
        - name: server
          image: gcr.io/google-samples/microservices-demo/checkoutservice:v0.1.2
          ports:
          - containerPort: 5050
          readinessProbe:
            exec:
              command: ["/bin/grpc_health_probe", "-addr=:5050"]
          livenessProbe:
            exec:
              command: ["/bin/grpc_health_probe", "-addr=:5050"]
          env:
          - name: PORT
            value: "5050"
          - name: PRODUCT_CATALOG_SERVICE_ADDR
            value: "productcatalogservice:3550"
          - name: SHIPPING_SERVICE_ADDR
            value: "shippingservice:50051"
          - name: PAYMENT_SERVICE_ADDR
            value: "paymentservice:50051"
          - name: EMAIL_SERVICE_ADDR
            value: "emailservice:5000"
          - name: CURRENCY_SERVICE_ADDR
            value: "currencyservice:7000"
          - name: CART_SERVICE_ADDR
            value: "cartservice:7070"
---
apiVersion: v1
kind: Service
metadata:
  name: checkoutservice
  namespace: hipstershop
  labels:
    app: checkoutservice
  annotations:
    ves.io/proxy-type: HTTP_PROXY
    ves.io/http2-enable: "true"
spec:
  type: ClusterIP
  selector:
    app: checkoutservice
  ports:
  - name: grpc
    port: 5050
    targetPort: 5050
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-cart
  namespace: hipstershop
spec:
  selector:
    matchLabels:
      app: redis-cart
  replicas: 1
  template:
    metadata:
      labels:
        app: redis-cart
    spec:
      containers:
      - name: master
        image: k8s.gcr.io/redis:e2e  # or just image: redis
        resources:
          requests:
            cpu: 100m
            memory: 200Mi
        ports:
        - containerPort: 6379
        volumeMounts:
        - mountPath: /data
          name: redis-data
        resources:
          limits:
            memory: 256Mi
            cpu: 125m
          requests:
            cpu: 70m
            memory: 200Mi
      volumes:
      - name: redis-data
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: redis-cart
  namespace: hipstershop
spec:
  type: ClusterIP
  selector:
    app: redis-cart
  ports:
  - name: redis
    port: 6379
    targetPort: 6379
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loadgenerator
  namespace: hipstershop
spec:
  selector:
    matchLabels:
      app: loadgenerator
  replicas: 1
  template:
    metadata:
      labels:
        app: loadgenerator
      annotations:
        sidecar.istio.io/rewriteAppHTTPProbers: "true"
    spec:
      terminationGracePeriodSeconds: 5
      restartPolicy: Always
      containers:
      - name: main
        image: gcr.io/solutions-team-280017/load-generator:https
        env:
        - name: FRONTEND_ADDR
          value: "http://frontend:80"
        - name: USERS
          value: "10"
        resources:
          requests:
            cpu: 300m
            memory: 256Mi
          limits:
            cpu: 500m
            memory: 512Mi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  namespace: hipstershop
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: server
          image: gcr.io/solutions-team-280017/hipster-frontend:latest
          ports:
          - containerPort: 8080
          env:
          - name: PORT
            value: "8080"
          - name: PRODUCT_CATALOG_SERVICE_ADDR
            value: "productcatalogservice:3550"
          - name: CURRENCY_SERVICE_ADDR
            value: "currencyservice:7000"
          - name: CART_SERVICE_ADDR
            value: "cartservice:7070"
          - name: RECOMMENDATION_SERVICE_ADDR
            value: "recommendationservice:8089"
          - name: SHIPPING_SERVICE_ADDR
            value: "shippingservice:50051"
          - name: CHECKOUT_SERVICE_ADDR
            value: "checkoutservice:5050"
          - name: AD_SERVICE_ADDR
            value: "adservice:9555"
---
apiVersion: v1
kind: Service
metadata:
  name: frontend
  namespace: hipstershop
  annotations:
    ves.io/proxy-type: HTTP_PROXY
  labels:
    app: frontend
    svc_name: frontend
    cis.f5.com/as3-tenant: AS3
    cis.f5.com/as3-app: K8sApplication
    cis.f5.com/as3-pool: web_pool
spec:
  selector:
    app: frontend
  ports:
  - name: frontend
    port: 80
    targetPort: 8080
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: hipstershop-configmap
  namespace: hipstershop
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
        "id": "example-virtual-server-for-hipstershop",
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
                  "servicePort": 8080,
                  "serverAddresses": []
                }
              ]
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



#╔════════════════════════════════════════════════════════════════════════╗
#║   Just a note if you want to clean up the deployments of hipstershop   ║
#╚════════════════════════════════════════════════════════════════════════╝
#
# kubectl delete --namespace hipstershop --force deployment.apps/emailservice
# kubectl delete --namespace hipstershop --force service/emailservice
# kubectl delete --namespace hipstershop --force deployment.apps/paymentservice
# kubectl delete --namespace hipstershop --force service/paymentservice
# kubectl delete --namespace hipstershop --force deployment.apps/productcatalogservice
# kubectl delete --namespace hipstershop --force service/productcatalogservice
# kubectl delete --namespace hipstershop --force deployment.apps/cartservice
# kubectl delete --namespace hipstershop --force service/cartservice
# kubectl delete --namespace hipstershop --force deployment.apps/currencyservice
# kubectl delete --namespace hipstershop --force service/currencyservice
# kubectl delete --namespace hipstershop --force deployment.apps/shippingservice
# kubectl delete --namespace hipstershop --force service/shippingservice
# kubectl delete --namespace hipstershop --force deployment.apps/recommendationservice
# kubectl delete --namespace hipstershop --force service/recommendationservice
# kubectl delete --namespace hipstershop --force deployment.apps/checkoutservice
# kubectl delete --namespace hipstershop --force service/checkoutservice
# kubectl delete --namespace hipstershop --force deployment.apps/frontend
# kubectl delete --namespace hipstershop --force service/frontend
# kubectl delete --namespace hipstershop --force deployment.apps/redis-cart
# kubectl delete --namespace hipstershop --force service/redis-cart
# kubectl delete --namespace hipstershop --force deployment.apps/loadgenerator
# kubectl delete --namespace hipstershop --force configmap/hipstershop-configmap
# kubectl delete --force namespace/hipstershop



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
