#!/bin/bash -xe

echo "Executing $0"

BigIPAddress="$1"
BigIPManagementPort="$2"
PodCIDR="$3"
Password="$4"

DEBUG=ON
cd /home/ubuntu

User=admin
Loop="Yes"
Loop_Period="1m"

PartitionName=kubernetes
VXLANProfileName=fl-vxlan
VXLANTunnelName=fl-tunnel
VXLANTunnelSelfIPName=fl-vxlan-selfip

PodCIDRPreFix=`echo "$PodCIDR" | egrep -o "^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\."`
PodCIDRSubNet=`echo "$PodCIDR" | egrep -o "\/(3[012]|[12][0-9]|[0-9])$"`
BigIPPodCIDRInFix="245"
BigIPPodCIDRSufFix="245"
BigIPPodCIDRSubNet="/24"
BigIPPodCIDR=$PodCIDRPreFix$BigIPPodCIDRInFix.0$BigIPPodCIDRSubNet
VXLANTunnelSelfIP=$PodCIDRPreFix$BigIPPodCIDRInFix.$BigIPPodCIDRSufFix$PodCIDRSubNet
BigIPAddressPort=$BigIPAddress:$BigIPManagementPort

if [ "$DEBUG" == "ON" ] ; then
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
fi

while ( [ "$Loop" == "Yes" ] ) ; do
 if ( ssh -o StrictHostKeyChecking=no $User@$BigIPAddress run util bash -c /config/UpGradeStatus.sh | egrep -o "^([0-9]{14} Custom Configuration Finished \.)$" ) ; then
  echo "`date +%Y%m%d%H%M%S` Big-IP is Ready ."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Big-IP is NOT Ready ."
  sleep $Loop_Period
 fi
done

echo "`date +%Y%m%d%H%M%S` Out of Checking Loop for Big-IP."

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create auth partition $PartitionName
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels vxlan $VXLANProfileName { app-service none port 8472 flooding-type none }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels tunnel $VXLANTunnelName { app-service none key 1 local-address $BigIPAddress profile $VXLANProfileName }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net self $VXLANTunnelSelfIPName { address $VXLANTunnelSelfIP vlan $VXLANTunnelName allow-service all }

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel $VXLANTunnelName all-properties
BigIPMAC=`ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel $VXLANTunnelName all-properties | egrep -o "([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}"`
if [ "$DEBUG" == "ON" ] ; then echo "`date +%Y%m%d%H%M%S` BigIPMAC=$BigIPMAC" ; fi



git clone -b develop https://github.com/gjwdyk/f5-agility-labs-containers.git ~/agilitydocs
cd ~/agilitydocs/docs/class1/kubernetes

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
while ( [ "$Loop" == "Yes" ] ) ; do
 if [ `kubectl get pods --all-namespaces | grep -i '\<k8s-bigip-ctlr' | grep -i 'Running' | wc -l` -ge 1 ] ; then
  echo "`date +%Y%m%d%H%M%S` Pod k8s-bigip-ctlr is running."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for pod k8s-bigip-ctlr to run."
  sleep $Loop_Period
 fi
done



sed 's/replicas: 2/replicas: 9/g' /home/ubuntu/agilitydocs/docs/class1/kubernetes/deployment-hello-world.yaml > /home/ubuntu/deployment-hello-world.yaml
kubectl create -f /home/ubuntu/deployment-hello-world.yaml

Loop="Yes"
while ( [ "$Loop" == "Yes" ] ) ; do
 if [ `kubectl get pods --all-namespaces | grep -i '\<f5-hello-world-web' | grep -i 'Running' | wc -l` -ge 9 ] ; then
  echo "`date +%Y%m%d%H%M%S` ALL pod f5-hello-world-web are running."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for one or more pod f5-hello-world-web to run."
  sleep $Loop_Period
 fi
done



cp /home/ubuntu/agilitydocs/docs/class1/kubernetes/clusterip-service-hello-world.yaml /home/ubuntu/clusterip-service-hello-world.yaml
kubectl create -f /home/ubuntu/clusterip-service-hello-world.yaml

sed s/kubernetes/$PartitionName/g /home/ubuntu/agilitydocs/docs/class1/kubernetes/ingress-hello-world.yaml > /home/ubuntu/Temporary1.yaml
sed s/10.1.1.4/$BigIPAddress/g /home/ubuntu/Temporary1.yaml > /home/ubuntu/ingress-hello-world.yaml
rm /home/ubuntu/Temporary*.yaml
kubectl create -f /home/ubuntu/ingress-hello-world.yaml



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep $Loop_Period

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net fdb tunnel $VXLANTunnelName
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net arp all

#╔═════════╗
#║   End   ║
#╚═════════╝
