#!/bin/bash -xe

BigIPAddress="$1"
BigIPManagementPort="$2"
PodCIDR="$3"
Password="$4"

DEBUG=ON

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
VXLANTunnelSelfIP=$PodCIDRPreFix$BigIPPodCIDRInFix.$BigIPPodCIDRSufFix$PodCIDRSubNet


if [ "$DEBUG" == "ON" ] ; then
 echo "BigIPAddress=$BigIPAddress"
 echo "BigIPManagementPort=$BigIPManagementPort"
 echo "PodCIDR=$PodCIDR"
 echo "Password=$Password"

 echo "PartitionName=$PartitionName"
 echo "VXLANProfileName=$VXLANProfileName"
 echo "VXLANTunnelName=$VXLANTunnelName"
 echo "VXLANTunnelSelfIPName=$VXLANTunnelSelfIPName"

 echo "PodCIDRPreFix=$PodCIDRPreFix"
 echo "PodCIDRSubNet=$PodCIDRSubNet"
 echo "BigIPPodCIDRInFix=$BigIPPodCIDRInFix"
 echo "BigIPPodCIDRSufFix=$BigIPPodCIDRSufFix"
 echo "BigIPPodCIDRSubNet=$BigIPPodCIDRSubNet"
 echo "VXLANTunnelSelfIP=$VXLANTunnelSelfIP"

 echo ""

fi



while ( [ "$Loop" == "Yes" ] ) ; do
 if ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show sys clock ; then
  echo "`date +%Y%m%d%H%M%S` Success : $?"
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Fail : $?"
  sleep $Loop_Period
 fi
done

echo "`date +%Y%m%d%H%M%S` Out of Loop"

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create auth partition $PartitionName
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels vxlan $VXLANProfileName { app-service none port 8472 flooding-type none }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels tunnel $VXLANTunnelName { app-service none key 1 local-address $BigIPAddress profile $VXLANProfileName }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net self $VXLANTunnelSelfIPName { address $VXLANTunnelSelfIP vlan $VXLANTunnelName allow-service all }

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel $VXLANTunnelName all-properties


