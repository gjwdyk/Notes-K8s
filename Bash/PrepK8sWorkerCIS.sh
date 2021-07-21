#!/bin/bash -xe

sudo su

WorkerNodeStatus=/home/ubuntu/WorkerNodeStatus
Loop="Yes"
Loop_Period="1m"



for arg in "$@"
do
 Loop="Yes"
 while ( [ "$Loop" == "Yes" ] ) ; do
  if ( runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no $arg sudo cat $WorkerNodeStatus | egrep -o "^([0-9]{14} Worker Node Ready \.)$" ) ; then
   echo "`date +%Y%m%d%H%M%S` Worker Node $arg is Ready ."
   Loop="No"
  else
   echo "`date +%Y%m%d%H%M%S` Worker Node $arg is NOT Ready ."
   sleep $Loop_Period
  fi
 done
 echo "`date +%Y%m%d%H%M%S` Out of Checking Loop for $arg ."
 runuser -u ubuntu -- ssh -o StrictHostKeyChecking=no $arg sudo `kubeadm token create --print-join-command`
done

sleep $Loop_Period



Loop="Yes"
while ( [ "$Loop" == "Yes" ] ) ; do
 if [ `kubectl get nodes | grep -i '\<Ready' | grep -i -v 'Master' | wc -l` -ge $# ] ; then
  echo "`date +%Y%m%d%H%M%S` All Nodes Already Joined The Kubernetes Cluster."
  Loop="No"
 else
  echo "`date +%Y%m%d%H%M%S` Waiting for one or more node(s) to join the K8s cluster."
  sleep $Loop_Period
 fi
done



runuser -l ubuntu -c 'kubectl get node --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get pod --all-namespaces -o wide'
runuser -l ubuntu -c 'kubectl get service --all-namespaces -o wide'


