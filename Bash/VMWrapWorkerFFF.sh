#!/bin/bash -xe

sudo echo "Executing $0"

NumberOfWorkerNodes=2
WorkerNodeNamePrefix='Server'

ContainerDVersion='1.5.5-0ubuntu3~20.04.2'
KubernetesVersion='1.23.4-00'
PodNetworkCIDR='10.244.0.0/16'
ServiceCIDR='10.96.0.0/12'
ContainerNetworkInterface='https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/Calico/CalicoCtl/v3.23.3/calico.yaml'

WorkerNodeStatus='/home/ubuntu/WorkerNodeStatus'

# Reference:
# https://tldp.org/LDP/abs/html/string-manipulation.html
#
# ${MYVAR#pattern}    # delete shortest match of pattern from the beginning
# ${MYVAR##pattern}   # delete longest match of pattern from the beginning
# ${MYVAR%pattern}    # delete shortest match of pattern from the end
# ${MYVAR%%pattern}   # delete longest match of pattern from the end

# K8sVersion=${KubernetesVersion%-*}
K8sVersion=${KubernetesVersion%%-*}



declare -a file_url
declare -a file_name
declare -a file_acl
declare -a file_result

file_url[0]="https://raw.githubusercontent.com/gjwdyk/NGINX-Notes/main/NMS-Instance-Manager/K8sServer/id_rsa"
file_name[0]="/home/ubuntu/.ssh/id_rsa"
file_acl[0]="600"
file_own[0]="ubuntu:ubuntu"

file_url[1]="https://raw.githubusercontent.com/gjwdyk/NGINX-Notes/main/NMS-Instance-Manager/K8sServer/id_rsa.pub"
file_name[1]="/home/ubuntu/.ssh/id_rsa.pub"
file_acl[1]="644"
file_own[1]="ubuntu:ubuntu"

file_url[2]="https://raw.githubusercontent.com/gjwdyk/NGINX-Notes/main/NMS-Instance-Manager/K8sServer/id_rsa.pub"
file_name[2]="/home/ubuntu/.ssh/authorized_keys"
file_acl[2]="600"
file_own[2]="ubuntu:ubuntu"

file_url[3]="https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/BuildK8sOnVM/VMPrepOSFFF.sh"
file_name[3]="/home/ubuntu/PrepareOS.sh"
file_acl[3]="777"
file_own[3]="ubuntu:ubuntu"

file_url[4]="https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/BuildK8sOnVM/VMPrepContainerRuntimeFFF.sh"
file_name[4]="/home/ubuntu/PrepareContainerRuntime.sh"
file_acl[4]="777"
file_own[4]="ubuntu:ubuntu"

file_url[5]="https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/BuildK8sOnVM/VMPrepCommonK8sFFF.sh"
file_name[5]="/home/ubuntu/PrepareCommonK8s.sh"
file_acl[5]="777"
file_own[5]="ubuntu:ubuntu"

max_counter=5

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

/home/ubuntu/PrepareOS.sh
/home/ubuntu/PrepareContainerRuntime.sh $ContainerDVersion
/home/ubuntu/PrepareCommonK8s.sh $KubernetesVersion $WorkerNodeStatus

#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

#╔═════════╗
#║   End   ║
#╚═════════╝
