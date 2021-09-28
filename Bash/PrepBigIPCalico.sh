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



#╔═══════════════════╗
#║   Review Status   ║
#╚═══════════════════╝

sleep $Loop_Period

kubectl get node -o wide -A
kubectl get deployment -o wide -A
kubectl get pod -o wide -A
kubectl get service -o wide -A

#╔═════════╗
#║   End   ║
#╚═════════╝
