#!/bin/bash -xe

sudo echo "Executing $0"

if [ -z "$1" ]; then
  PodNetworkCIDR='10.244.0.0/16'
else
  PodNetworkCIDR="$1"
fi

if [ -z "$2" ]; then
  ServiceCIDR='10.96.0.0/12'
else
  ServiceCIDR="$2"
fi

if [ -z "$3" ]; then
  KubernetesVersion='1.23.4'
else
  KubernetesVersion="$3"
fi

if [ -z "$4" ]; then
  ContainerNetworkInterface='https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/Calico/CalicoCtl/v3.23.3/calico.yaml'
else
  ContainerNetworkInterface="$4"
fi

Loop_Period="9s"



sudo kubeadm init --pod-network-cidr=$PodNetworkCIDR --service-cidr=$ServiceCIDR --kubernetes-version=$KubernetesVersion

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl



declare -a file_url
declare -a file_name
declare -a file_acl
declare -a file_result

file_url[0]="$ContainerNetworkInterface"
file_name[0]="/home/ubuntu/ContainerNetworkInterface.yaml"
file_acl[0]="777"
file_own[0]="ubuntu:ubuntu"

max_counter=0

URLRegEx="^(http:\/\/|https:\/\/)?[a-z0-9]+((\-|\.)[a-z0-9]+)*\.[a-z]{2,}(:[0-9]{1,5})?(\/.*)*$"

for counter in $(seq 0 $max_counter); do
 if [[ ${file_url[$counter]} =~ $URLRegEx ]] ; then
  file_result[$counter]=$(/usr/bin/curl -sk -L --retry 333 -w "%{http_code}" ${file_url[$counter]} -o ${file_name[$counter]})
  if [[ ${file_result[$counter]} == 200 ]]; then
   echo "$counter ; HTTP ${file_result[$counter]} ; ${file_name[$counter]} download complete."
   chown ${file_own[$counter]} ${file_name[$counter]}
   chmod ${file_acl[$counter]} ${file_name[$counter]}
  else
   echo "$counter ; HTTP ${file_result[$counter]} ; Failed to download ${file_name[$counter]} ; Continuing . . ."
  fi
 else
  echo "$counter ; Reference to the ${file_name[$counter]} was not a URL ; Continuing . . ."
 fi
done

# You can change/modify the downloaded descriptor yaml file before invoke the creation of CNI

kubectl apply -f /home/ubuntu/ContainerNetworkInterface.yaml



Loop="Yes"
while ( [ "$Loop" == "Yes" ] ) ; do
 if [ `kubectl get nodes | grep -i "$(hostname)" | grep -i 'control-plane' | grep -i '\<Ready' | wc -l` -ge 1 ] ; then
  echo "`date +%Y%m%d%H%M%S` Control Plane Node is Ready."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for Control Plane Node to be Ready."
  sleep $Loop_Period
 fi
done

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

kubectl get node --all-namespaces -o wide
kubectl get pod --all-namespaces -o wide
kubectl get service --all-namespaces -o wide

#╔═════════╗
#║   End   ║
#╚═════════╝
