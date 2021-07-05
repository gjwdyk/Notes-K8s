#!/bin/bash -xe

BigIPAddress="$1"
User=admin
Loop="Yes"
Loop_Period="1m"



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

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create auth partition kubernetes
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels vxlan fl-vxlan { app-service none port 8472 flooding-type none }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net tunnels tunnel fl-tunnel { app-service none key 1 local-address $BigIPAddress profile fl-vxlan }
ssh -o StrictHostKeyChecking=no $User@$BigIPAddress create net self fl-vxlan-selfip { address 10.244.21.1/16 vlan fl-tunnel allow-service all }

ssh -o StrictHostKeyChecking=no $User@$BigIPAddress show net tunnels tunnel fl-tunnel all-properties


