#!/bin/bash -xe

echo "Executing $0"

cd /home/ubuntu

Loop="Yes"
Loop_Period="1m"



kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: f5-demo-httpd

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-red
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-red
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Red F5 Demo Application"
        - name: F5DEMO_COLOR
          value: 'ff0000'
        - name: F5DEMO_NODENAME_SSL
          value: "The Red SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 'ff0000'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-green
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-green
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Green F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '008000'
        - name: F5DEMO_NODENAME_SSL
          value: "The Green SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '008000'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-blue
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-blue
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Blue F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '0000ff'
        - name: F5DEMO_NODENAME_SSL
          value: "The Blue SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '0000ff'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-maroon
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-maroon
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Maroon F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '800000'
        - name: F5DEMO_NODENAME_SSL
          value: "The Maroon SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '800000'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-yellow
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-yellow
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Yellow F5 Demo Application"
        - name: F5DEMO_COLOR
          value: 'ffff00'
        - name: F5DEMO_NODENAME_SSL
          value: "The Yellow SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 'ffff00'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-olive
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-olive
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Olive F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '808000'
        - name: F5DEMO_NODENAME_SSL
          value: "The Olive SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '808000'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-lime
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-lime
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Lime F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '00ff00'
        - name: F5DEMO_NODENAME_SSL
          value: "The Lime SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '00ff00'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-aqua
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-aqua
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Aqua F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '00ffff'
        - name: F5DEMO_NODENAME_SSL
          value: "The Aqua SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '00ffff'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-teal
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-teal
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Teal F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '008080'
        - name: F5DEMO_NODENAME_SSL
          value: "The Teal SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '008080'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-navy
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-navy
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Navy F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '000080'
        - name: F5DEMO_NODENAME_SSL
          value: "The Navy SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '000080'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-fuchsia
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-fuchsia
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Fuchsia F5 Demo Application"
        - name: F5DEMO_COLOR
          value: 'ff00ff'
        - name: F5DEMO_NODENAME_SSL
          value: "The Fuchsia SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 'ff00ff'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-purple
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-purple
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Purple F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '800080'
        - name: F5DEMO_NODENAME_SSL
          value: "The Purple SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '800080'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-orange
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-orange
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Orange F5 Demo Application"
        - name: F5DEMO_COLOR
          value: 'ff8000'
        - name: F5DEMO_NODENAME_SSL
          value: "The Orange SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 'ff8000'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-lawngreen
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-lawngreen
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Lawn Green F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '80ff00'
        - name: F5DEMO_NODENAME_SSL
          value: "The Lawn Green SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '80ff00'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-springgreen
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-springgreen
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Spring Green F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '00ff80'
        - name: F5DEMO_NODENAME_SSL
          value: "The Spring Green SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '00ff80'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-dodgerblue
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-dodgerblue
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Dodger Blue F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '0080ff'
        - name: F5DEMO_NODENAME_SSL
          value: "The Dodger Blue SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '0080ff'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-pink
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-pink
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Pink F5 Demo Application"
        - name: F5DEMO_COLOR
          value: 'ff0080'
        - name: F5DEMO_NODENAME_SSL
          value: "The Pink SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 'ff0080'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-httpd-violet
  namespace: f5-demo-httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-httpd
  template:
    metadata:
      labels:
        app: f5-demo-httpd
    spec:
      containers:
      - name: f5-demo-httpd-violet
        image: f5devcentral/f5-demo-httpd:nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        env:
        - name: F5DEMO_APP
          value: website
        - name: F5DEMO_NODENAME
          value: "The Violet F5 Demo Application"
        - name: F5DEMO_COLOR
          value: '8000ff'
        - name: F5DEMO_NODENAME_SSL
          value: "The Violet SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: '8000ff'
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: v1
kind: Service
metadata:
  name: f5-demo-httpd
  namespace: f5-demo-httpd
  labels:
    app: f5-demo-httpd
    cis.f5.com/as3-tenant: AS3-Tenant-0
    cis.f5.com/as3-app: K8s-Application-0
    cis.f5.com/as3-pool: as3_pool_0
spec:
  ports:
  - name: f5-demo-httpd
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: f5-demo-httpd

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: f5-demo-httpd-configmap
  namespace: f5-demo-httpd
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
        "id": "example-virtual-server-for-f5-demo-httpd",
        "label": "http",
        "remark": "An Example",
        "AS3-Tenant-0": {
          "class": "Tenant",
          "K8s-Application-0": {
            "class": "Application",
            "template": "https",
            "serviceMain": {
              "class": "Service_HTTPS",
              "virtualAddresses": [
                "10.1.1.245"
              ],
              "serverTLS": "ServiceHTTPS_TLSServer",
              "pool": "as3_pool_0",
              "virtualPort": 443,
              "persistenceMethods": [],
              "profileHTTP": { "use": "ServiceHTTPS_HTTPProfile" },
              "ipIntelligencePolicy": { "bigip": "/Common/IP_Intelligence_Policy" },
              "profileDOS": { "bigip": "/Common/HTTP_Network_DoS_Protection_Profile" },
              "profileAnalytics": { "bigip": "/Common/HTTP_Analytics_Profile" },
              "profileAnalyticsTcp": { "bigip": "/Common/TCP_Analytics_Profile" }
            },
            "as3_pool_0": {
              "class": "Pool",
              "monitors": [
                "http"
              ],
              "loadBalancingMode": "round-robin",
              "members": [
                {
                  "servicePort": 80,
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
    cis.f5.com/as3-tenant: AS3-Tenant-1
    cis.f5.com/as3-app: K8s-Application-1
    cis.f5.com/as3-pool: as3_pool_1
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
        "remark": "An Example",
        "AS3-Tenant-1": {
          "class": "Tenant",
          "K8s-Application-1": {
            "class": "Application",
            "template": "https",
            "serviceMain": {
              "class": "Service_HTTPS",
              "virtualAddresses": [
                "10.1.1.246"
              ],
              "serverTLS": "ServiceHTTPS_TLSServer",
              "pool": "as3_pool_1",
              "virtualPort": 443,
              "persistenceMethods": [],
              "profileHTTP": { "use": "ServiceHTTPS_HTTPProfile" },
              "ipIntelligencePolicy": { "bigip": "/Common/IP_Intelligence_Policy" },
              "profileDOS": { "bigip": "/Common/HTTP_Network_DoS_Protection_Profile" },
              "profileAnalytics": { "bigip": "/Common/HTTP_Analytics_Profile" },
              "profileAnalyticsTcp": { "bigip": "/Common/TCP_Analytics_Profile" }
            },
            "as3_pool_1": {
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
    cis.f5.com/as3-tenant: AS3-Tenant-2
    cis.f5.com/as3-app: K8s-Application-2
    cis.f5.com/as3-pool: as3_pool_2
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
        "AS3-Tenant-2": {
          "class": "Tenant",
          "K8s-Application-2": {
            "class": "Application",
            "template": "https",
            "serviceMain": {
              "class": "Service_HTTPS",
              "virtualAddresses": [
                "10.1.1.247"
              ],
              "serverTLS": "ServiceHTTPS_TLSServer",
              "pool": "as3_pool_2",
              "virtualPort": 443,
              "persistenceMethods": [],
              "profileHTTP": { "use": "ServiceHTTPS_HTTPProfile" },
              "ipIntelligencePolicy": { "bigip": "/Common/IP_Intelligence_Policy" },
              "profileDOS": { "bigip": "/Common/HTTP_Network_DoS_Protection_Profile" },
              "profileAnalytics": { "bigip": "/Common/HTTP_Analytics_Profile" },
              "profileAnalyticsTcp": { "bigip": "/Common/TCP_Analytics_Profile" }
            },
            "as3_pool_2": {
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



Loop="Yes"
ItemCount=`kubectl get pods --all-namespaces | grep -i '\<f5-demo-httpd-' | wc -l`
while ( [ "$Loop" == "Yes" ] ) ; do
 if [ `kubectl get pods --all-namespaces | grep -i '\<f5-demo-httpd-' | grep -i 'Running' | wc -l` -ge $ItemCount ] ; then
  echo "`date +%Y%m%d%H%M%S` ALL pod f5-demo-httpd are running."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for all pod(s) f5-demo-httpd to run."
  sleep $Loop_Period
 fi
done



#╔══════════════════════════════════════════════════════════════════════════╗
#║   Just a note if you want to clean up the deployments of f5-demo-httpd   ║
#╚══════════════════════════════════════════════════════════════════════════╝
#
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-aqua
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-blue
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-dodgerblue
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-fuchsia
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-green
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-lawngreen
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-lime
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-maroon
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-navy
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-olive
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-orange
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-pink
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-purple
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-red
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-springgreen
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-teal
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-violet
# kubectl delete --namespace f5-demo-httpd --force deployment/f5-demo-httpd-yellow
# kubectl delete --namespace f5-demo-httpd --force configmap/f5-demo-httpd-configmap
# kubectl delete --namespace f5-demo-httpd --force service/f5-demo-httpd
# kubectl delete --force namespace/f5-demo-httpd



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
