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
    cis.f5.com/as3-tenant: AS3
    cis.f5.com/as3-app: K8sApplication
    cis.f5.com/as3-pool: web_pool
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
