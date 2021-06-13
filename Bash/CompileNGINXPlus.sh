#!/bin/bash -xe

sudo su

if [[ $5 != "Yes" ]]; then
 apt install -y make
fi

cd /home/ubuntu
git clone https://github.com/nginxinc/kubernetes-ingress/
cd kubernetes-ingress/
git checkout $1

if [[ $5 != "Yes" ]]; then
 mv /home/ubuntu/nginx-repo.crt /home/ubuntu/kubernetes-ingress/nginx-repo.crt
 mv /home/ubuntu/nginx-repo.key /home/ubuntu/kubernetes-ingress/nginx-repo.key
fi

docker login -u $2 -p $3

if [[ $5 != "Yes" ]]; then
 make debian-image-plus PREFIX=$4 TAG=$1 TARGET=container
 make push PREFIX=$4 TAG=$1
fi
