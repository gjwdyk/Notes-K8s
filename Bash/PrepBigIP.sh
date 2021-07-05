#!/bin/bash -xe

BigIPAddress="$1"
Loop="Yes"
Loop_Period="2m 2s"



while ( [ "$Loop" == "Yes" ] ) ; do
 if ssh -o StrictHostKeyChecking=no admin@$BigIPAddress show sys clock ; then echo "`date +%Y%m%d%H%M%S` Success : $?" ; else echo "`date +%Y%m%d%H%M%S` Fail : $?" ; fi
 sleep $Loop_Period
done


