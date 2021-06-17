#!/bin/bash -xe

sudo su

if [[ $3 != "Yes" ]]; then
 apt install -y make
fi

cd /home/ubuntu
git clone https://github.com/nginxinc/kubernetes-ingress/
cd kubernetes-ingress/
git checkout $2

if [[ $3 != "Yes" ]]; then
 mv /home/ubuntu/nginx-repo.crt /home/ubuntu/kubernetes-ingress/nginx-repo.crt
 mv /home/ubuntu/nginx-repo.key /home/ubuntu/kubernetes-ingress/nginx-repo.key

 docker login -u $4 -p $5

 make debian-image-plus PREFIX=$1 TAG=$2 TARGET=container
 make push PREFIX=$1 TAG=$2
fi
