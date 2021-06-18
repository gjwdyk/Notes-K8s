#!/bin/bash -xe

cd /home/ubuntu

kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: cafe

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: coffee
  namespace: cafe
spec:
  replicas: 3
  selector:
    matchLabels:
      app: coffee
  template:
    metadata:
      labels:
        app: coffee
    spec:
      containers:
      - name: coffee
        image: nginxdemos/nginx-hello:latest
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080

---

apiVersion: v1
kind: Service
metadata:
  name: coffee
  namespace: cafe
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: coffee

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: milk
  namespace: cafe
spec:
  replicas: 3
  selector:
    matchLabels:
      app: milk
  template:
    metadata:
      labels:
        app: milk
    spec:
      containers:
      - name: milk
        image: nginxdemos/nginx-hello:latest
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080

---

apiVersion: v1
kind: Service
metadata:
  name: milk
  namespace: cafe
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: milk

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: tea
  namespace: cafe
spec:
  replicas: 3
  selector:
    matchLabels:
      app: tea
  template:
    metadata:
      labels:
        app: tea
    spec:
      containers:
      - name: tea
        image: nginxdemos/nginx-hello:plain-text
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080

---

apiVersion: v1
kind: Service
metadata:
  name: tea
  namespace: cafe
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: tea

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: water
  namespace: cafe
spec:
  replicas: 3
  selector:
    matchLabels:
      app: water
  template:
    metadata:
      labels:
        app: water
    spec:
      containers:
      - name: water
        image: nginxdemos/nginx-hello:plain-text
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080

---

apiVersion: v1
kind: Service
metadata:
  name: water
  namespace: cafe
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: water

---

apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: cafe
  namespace: cafe
spec:
  ingressClassName: nginx
  rules:
  - host: $1
    http:
      paths:
      - path: /milk
        backend:
          serviceName: milk
          servicePort: 80
      - path: /coffee
        backend:
          serviceName: coffee
          servicePort: 80
      - path: /tea
        backend:
          serviceName: tea
          servicePort: 80
      - path: /water
        backend:
          serviceName: water
          servicePort: 80
EOF



kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: dvwa

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: dvwa
  namespace: dvwa
spec:
  selector:
    matchLabels:
      app: dvwa
  replicas: 1
  template:
    metadata:
      labels:
        app: dvwa
    spec:
      containers:
      - name: dvwa
        image: vulnerables/web-dvwa
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: dvwa
  name: dvwa
  namespace: dvwa
spec:
  ports:
  - nodePort: 31081
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: dvwa
  type: NodePort

---

apiVersion: v1
kind: Namespace
metadata:
  name: hackazon

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: hackazon
  namespace: hackazon
spec:
  selector:
    matchLabels:
      app: hackazon
  replicas: 1
  template:
    metadata:
      labels:
        app: hackazon
    spec:
      containers:
      - name: hackazon
        image: bepsoccer/all-in-one-hackazon
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: hackazon
  name: hackazon
  namespace: hackazon
spec:
  ports:
  - nodePort: 31082
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: hackazon
  type: NodePort

---

apiVersion: v1
kind: Namespace
metadata:
  name: juice-shop

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: juice-shop
  namespace: juice-shop
spec:
  replicas: 1
  selector:
    matchLabels:
      app: juice-shop
  template:
    metadata:
      labels:
        app: juice-shop
    spec:
      containers:
      - name: juice-shop
        image: bkimminich/juice-shop:latest
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 3000
          name: http
          protocol: TCP

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: juice-shop
  name: juice-shop
  namespace: juice-shop
spec:
  ports:
  - nodePort: 31083
    port: 80
    protocol: TCP
    targetPort: 3000
    name: http
  selector:
    app: juice-shop
  type: NodePort
EOF



kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: f5-demo-app

---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: f5-demo-app
  namespace: f5-demo-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: f5-demo-app
  template:
    metadata:
      labels:
        app: f5-demo-app
    spec:
      containers:
      - name: f5-demo-app
        image: f5devcentral/f5-demo-app
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
          name: http
          protocol: TCP

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: f5-demo-app
  name: f5-demo-app
  namespace: f5-demo-app
spec:
  ports:
  - nodePort: 31084
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: f5-demo-app
  type: NodePort
EOF



kubectl create -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: f5-demo-httpd

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
      app: f5-demo-httpd-orange
  template:
    metadata:
      labels:
        app: f5-demo-httpd-orange
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
          value: ed7b0c
        - name: F5DEMO_NODENAME_SSL
          value: "The Orange SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: ed7b0c
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd-green.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: f5-demo-httpd-orange
  name: f5-demo-httpd-orange
  namespace: f5-demo-httpd
spec:
  ports:
  - nodePort: 31085
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: f5-demo-httpd-orange
  type: NodePort

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
      app: f5-demo-httpd-green
  template:
    metadata:
      labels:
        app: f5-demo-httpd-green
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
          value: a0bf37
        - name: F5DEMO_NODENAME_SSL
          value: "The Green SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: a0bf37
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd-blue.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: f5-demo-httpd-green
  name: f5-demo-httpd-green
  namespace: f5-demo-httpd
spec:
  ports:
  - nodePort: 31086
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: f5-demo-httpd-green
  type: NodePort

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
      app: f5-demo-httpd-blue
  template:
    metadata:
      labels:
        app: f5-demo-httpd-blue
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
          value: 0194d2
        - name: F5DEMO_NODENAME_SSL
          value: "The Blue SSL F5 Demo Application (SSL)"
        - name: F5DEMO_COLOR_SSL
          value: 0194d2
        - name: F5DEMO_BACKEND_URL
          value: "http://f5-demo-httpd-orange.f5-demo-httpd.svc.cluster.local/"

---

apiVersion: v1
kind: Service
metadata:
  labels:
    app: f5-demo-httpd-blue
  name: f5-demo-httpd-blue
  namespace: f5-demo-httpd
spec:
  ports:
  - nodePort: 31087
    port: 80
    protocol: TCP
    targetPort: 80
    name: http
  selector:
    app: f5-demo-httpd-blue
  type: NodePort
EOF



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A
