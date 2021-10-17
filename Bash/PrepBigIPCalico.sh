#!/bin/bash -xe

echo "Executing $0"

BigIPAddress=$1
BigIPManagementPort=$2
PodCIDR=$3
Password=$4

DEBUG=ON
cd /home/ubuntu

User=admin
Loop="Yes"
Loop_Period="1m"

PartitionName=kubernetes
VXLANProfileName=fl-vxlan
VXLANTunnelName=fl-tunnel
VXLANTunnelSelfIPName=fl-vxlan-selfip

PodCIDRPreFix=`echo $PodCIDR | egrep -o "^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\."`
PodCIDRSubNet=`echo $PodCIDR | egrep -o "\/(3[012]|[12][0-9]|[0-9])$"`
BigIPPodCIDRInFix="245"
BigIPPodCIDRSufFix="245"
BigIPPodCIDRSubNet="/24"
BigIPPodCIDR=$PodCIDRPreFix$BigIPPodCIDRInFix.0$BigIPPodCIDRSubNet
VXLANTunnelSelfIP=$PodCIDRPreFix$BigIPPodCIDRInFix.$BigIPPodCIDRSufFix$PodCIDRSubNet
BigIPAddressPort=$BigIPAddress:$BigIPManagementPort



if [ -z $5 ] ; then : ; else K8sMaster1IPAddress=$5
 if [ -z $6 ] ; then : ; else K8sWorker1IPAddress=$6
  if [ -z $7 ] ; then : ; else K8sWorker2IPAddress=$7
   if [ -z $8 ] ; then : ; else K8sWorker3IPAddress=$8
    if [ -z $9 ] ; then : ; else K8sWorker4IPAddress=$9
     if [ -z ${10} ] ; then : ; else K8sWorker5IPAddress=${10}
      if [ -z ${11} ] ; then : ; else K8sWorker6IPAddress=${11}
       if [ -z ${12} ] ; then : ; else K8sWorker7IPAddress=${12}
        if [ -z ${13} ] ; then : ; else K8sWorker8IPAddress=${13}
         if [ -z ${14} ] ; then : ; else K8sWorker9IPAddress=${14}
         fi
        fi
       fi
      fi
     fi
    fi
   fi
  fi
 fi
fi



if [ $DEBUG == "ON" ] ; then
 echo "`date +%Y%m%d%H%M%S` BigIPAddress=$BigIPAddress"
 echo "`date +%Y%m%d%H%M%S` BigIPManagementPort=$BigIPManagementPort"
 echo "`date +%Y%m%d%H%M%S` BigIPAddressPort=$BigIPAddressPort"
 echo "`date +%Y%m%d%H%M%S` User=$User"
 echo "`date +%Y%m%d%H%M%S` Password=$Password"
 echo "`date +%Y%m%d%H%M%S` PartitionName=$PartitionName"
 echo "`date +%Y%m%d%H%M%S` VXLANProfileName=$VXLANProfileName"
 echo "`date +%Y%m%d%H%M%S` VXLANTunnelName=$VXLANTunnelName"
 echo "`date +%Y%m%d%H%M%S` VXLANTunnelSelfIPName=$VXLANTunnelSelfIPName"
 echo "`date +%Y%m%d%H%M%S` PodCIDR=$PodCIDR"
 echo "`date +%Y%m%d%H%M%S` PodCIDRPreFix=$PodCIDRPreFix"
 echo "`date +%Y%m%d%H%M%S` PodCIDRSubNet=$PodCIDRSubNet"
 echo "`date +%Y%m%d%H%M%S` BigIPPodCIDRInFix=$BigIPPodCIDRInFix"
 echo "`date +%Y%m%d%H%M%S` BigIPPodCIDRSufFix=$BigIPPodCIDRSufFix"
 echo "`date +%Y%m%d%H%M%S` BigIPPodCIDRSubNet=$BigIPPodCIDRSubNet"
 echo "`date +%Y%m%d%H%M%S` BigIPPodCIDR=$BigIPPodCIDR"
 echo "`date +%Y%m%d%H%M%S` VXLANTunnelSelfIP=$VXLANTunnelSelfIP"
 if [ -z $K8sMaster1IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sMaster1IPAddress=$K8sMaster1IPAddress" ; fi
 if [ -z $K8sWorker1IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker1IPAddress=$K8sWorker1IPAddress" ; fi
 if [ -z $K8sWorker2IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker2IPAddress=$K8sWorker2IPAddress" ; fi
 if [ -z $K8sWorker3IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker3IPAddress=$K8sWorker3IPAddress" ; fi
 if [ -z $K8sWorker4IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker4IPAddress=$K8sWorker4IPAddress" ; fi
 if [ -z $K8sWorker5IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker5IPAddress=$K8sWorker5IPAddress" ; fi
 if [ -z $K8sWorker6IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker6IPAddress=$K8sWorker6IPAddress" ; fi
 if [ -z $K8sWorker7IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker7IPAddress=$K8sWorker7IPAddress" ; fi
 if [ -z $K8sWorker8IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker8IPAddress=$K8sWorker8IPAddress" ; fi
 if [ -z $K8sWorker9IPAddress ] ; then : ; else echo "`date +%Y%m%d%H%M%S` K8sWorker9IPAddress=$K8sWorker9IPAddress" ; fi
fi

while ( [ $Loop == "Yes" ] ) ; do
 if ( ssh -o StrictHostKeyChecking=no $User@$BigIPAddress run util bash -c /config/UpGradeStatus.sh | egrep -o "^([0-9]{14} Custom Configuration Finished \.)$" ) ; then
  echo "`date +%Y%m%d%H%M%S` Big-IP is Ready ."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Big-IP is NOT Ready ."
  sleep $Loop_Period
 fi
done

echo "`date +%Y%m%d%H%M%S` Out of Checking Loop for Big-IP."



#╔═════════╗
#║   BGP   ║
#╚═════════╝

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress modify net self $BigIPAddress/24 allow-service add { tcp:179 }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress modify net route-domain 0 routing-protocol add { BGP }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \'\!\\nno service password-encryption\\n\!\\nrouter bgp 64512\\n bgp graceful-restart restart-time 120\\n neighbor calico-k8s peer-group\\n neighbor calico-k8s remote-as 64512\\n\' \> /config/zebos/rd0/ZebOS.conf\"
if [ -z $K8sMaster1IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sMaster1IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker1IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker1IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker2IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker2IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker3IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker3IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker4IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker4IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker5IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker5IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker6IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker6IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker7IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker7IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker8IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker8IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
if [ -z $K8sWorker9IPAddress ] ; then : ; else ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \' neighbor $K8sWorker9IPAddress peer-group calico-k8s\\n\' \>\> /config/zebos/rd0/ZebOS.conf\" ; fi
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress bash -c \"printf \'\!\\nline con 0\\n login\\nline vty 0 39\\n login\\n\!\\nend\\n\' \>\> /config/zebos/rd0/ZebOS.conf\"
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress restart /sys service tmrouted



# Original URL is https://github.com/projectcalico/calicoctl/releases/download/v3.20.1/calicoctl
# however unfortunately some people have short-circuit in the head
# Original URL can not be downloaded by script, download manual is OK
# So to do Automation, one must do it manually. Great!
#
#curl -O -L https://github.com/projectcalico/calicoctl/releases/download/v3.20.1/calicoctl

curl -O -L --retry 333 https://aws-f5-singapore-hc-demo-bucket-files.s3.ap-southeast-1.amazonaws.com/Calico/CalicoCtl/v3.20.2/calicoctl
chmod +x calicoctl
sudo mv calicoctl /usr/local/bin
sudo mkdir /etc/calico

cat <<EOF > /home/ubuntu/calicoctl.cfg
apiVersion: projectcalico.org/v3
kind: CalicoAPIConfig
metadata:
spec:
  datastoreType: "kubernetes"
  kubeconfig: "/home/ubuntu/.kube/config"
EOF

sudo chmod 666 /home/ubuntu/calicoctl.cfg
sudo chown root:root /home/ubuntu/calicoctl.cfg
sudo mv /home/ubuntu/calicoctl.cfg /etc/calico/

cat <<EOF > /home/ubuntu/CalicoBGPConfiguration.yaml
apiVersion: projectcalico.org/v3
kind: BGPConfiguration
metadata:
  name: default
spec:
  logSeverityScreen: Info
  nodeToNodeMeshEnabled: true
  asNumber: 64512
EOF

calicoctl create -f /home/ubuntu/CalicoBGPConfiguration.yaml

cat <<EOF > /home/ubuntu/CalicoBGPPeer.yaml
apiVersion: projectcalico.org/v3
kind: BGPPeer
metadata:
  name: bgppeer-global-bigip
spec:
  peerIP: $BigIPAddress
  asNumber: 64512
EOF

calicoctl create -f /home/ubuntu/CalicoBGPPeer.yaml



#╔═══════════╗
#║   VxLAN   ║
#╚═══════════╝

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create auth partition $PartitionName
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels vxlan $VXLANProfileName { app-service none port 8472 flooding-type none }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels tunnel $VXLANTunnelName { app-service none key 1 local-address $BigIPAddress profile $VXLANProfileName }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net self $VXLANTunnelSelfIPName { address $VXLANTunnelSelfIP vlan $VXLANTunnelName allow-service all }

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel $VXLANTunnelName all-properties
BigIPMAC=`ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel $VXLANTunnelName all-properties | egrep -o "([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}"`
if [ $DEBUG == "ON" ] ; then echo "`date +%Y%m%d%H%M%S` BigIPMAC=$BigIPMAC" ; fi



kubectl create secret generic bigip-login -n kube-system --from-literal=username=$User --from-literal=password=$Password
kubectl create serviceaccount k8s-bigip-ctlr -n kube-system
kubectl create clusterrolebinding k8s-bigip-ctlr-clusteradmin --clusterrole=cluster-admin --serviceaccount=kube-system:k8s-bigip-ctlr



sed s+0.0.0.0/0+$BigIPPodCIDR+g /home/ubuntu/BigIPCISNodeTemplate > /home/ubuntu/Temporary1.yaml
sed s/00:00:00:00:00:00/$BigIPMAC/g /home/ubuntu/Temporary1.yaml > /home/ubuntu/Temporary2.yaml
sed s/0.0.0.0/$BigIPAddress/g /home/ubuntu/Temporary2.yaml > /home/ubuntu/BigIPCISNode.yaml
rm /home/ubuntu/Temporary*.yaml

kubectl create -f /home/ubuntu/BigIPCISNode.yaml



sed s+0.0.0.0:0+$BigIPAddressPort+g /home/ubuntu/BigIPCISClusterDeploymentTemplate > /home/ubuntu/Temporary1.yaml
sed s/kubernetes-partition/$PartitionName/g /home/ubuntu/Temporary1.yaml > /home/ubuntu/Temporary2.yaml
sed s/flannel-tunnel/$VXLANTunnelName/g /home/ubuntu/Temporary2.yaml > /home/ubuntu/BigIPCISClusterDeployment.yaml
rm /home/ubuntu/Temporary*.yaml

kubectl create -f /home/ubuntu/BigIPCISClusterDeployment.yaml

Loop="Yes"
ItemCount=`kubectl get pods --all-namespaces | grep -i '\<k8s-bigip-ctlr' | wc -l`
while ( [ $Loop == "Yes" ] ) ; do
 if [ `kubectl get pods --all-namespaces | grep -i '\<k8s-bigip-ctlr' | grep -i 'Running' | wc -l` -ge $ItemCount ] ; then
  echo "`date +%Y%m%d%H%M%S` Pod k8s-bigip-ctlr is running."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for pod k8s-bigip-ctlr to run."
  sleep $Loop_Period
 fi
done



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep $Loop_Period

calicoctl get nodes
calicoctl get bgpPeer
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress imish -e \'show bgp neighbor\'

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net fdb tunnel $VXLANTunnelName
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net arp all

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A

#╔═════════╗
#║   End   ║
#╚═════════╝
