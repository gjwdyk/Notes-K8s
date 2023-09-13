#!/bin/bash -xe

sudo su
echo "Executing $0"

kubeadm init --pod-network-cidr=$1 --service-cidr=$2 --kubernetes-version="v1.28.1"

runuser -l ubuntu -c 'mkdir -p $HOME/.kube'
runuser -l ubuntu -c 'sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config'
runuser -l ubuntu -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

sleep 1m

kubectl completion bash > /etc/bash_completion.d/kubectl



declare -a file_url
declare -a file_name
declare -a file_acl
declare -a file_result

file_url[0]="$3"
file_name[0]="/home/ubuntu/calico.yaml"
file_acl[0]="777"
file_own[0]="ubuntu:ubuntu"

max_counter=0

URLRegEx="^(http:\/\/|https:\/\/)?[a-z0-9]+((\-|\.)[a-z0-9]+)*\.[a-z]{2,}(:[0-9]{1,5})?(\/.*)*$"

for counter in $(seq 0 $max_counter); do
 if [[ ${file_url[$counter]} =~ $URLRegEx ]]; then
  file_result[$counter]=$(/usr/bin/curl -sk --retry 333 -w "%{http_code}" ${file_url[$counter]} -o ${file_name[$counter]})
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
#
# sed s/\<ETCD_IP\>/10.1.1.11/g /home/ubuntu/calico.yaml > /home/ubuntu/Temporary1.yaml
# sed s/\<ETCD_PORT\>/2379/g /home/ubuntu/Temporary1.yaml > /home/ubuntu/calico.yaml
# rm /home/ubuntu/Temporary*.yaml

runuser -u ubuntu -- kubectl apply -f /home/ubuntu/calico.yaml

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep 1m

runuser -l ubuntu -c 'kubectl get node --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get pod --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get service --all-namespaces -o wide'

#╔═════════╗
#║   End   ║
#╚═════════╝
