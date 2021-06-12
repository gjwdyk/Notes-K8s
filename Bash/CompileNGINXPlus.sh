#!/bin/bash -xe

sudo su

apt install -y make

cd /home/ubuntu
git clone https://github.com/nginxinc/kubernetes-ingress/
cd kubernetes-ingress/
git checkout $1

mv /home/ubuntu/nginx-repo.crt /home/ubuntu/kubernetes-ingress/nginx-repo.crt
mv /home/ubuntu/nginx-repo.key /home/ubuntu/kubernetes-ingress/nginx-repo.key

docker login -u $2 -p $3

make debian-image-plus PREFIX=$4 TARGET=container
make push PREFIX=$4
