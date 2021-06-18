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

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A
