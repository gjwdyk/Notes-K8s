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



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A
