#!/bin/bash -xe

UpGradeResult=/config/UpgradeResult

if [[ `cat $UpGradeResult` =~ ^([0-9]{14} Custom Configuration Finished \.)$ ]] ; then
 echo "Success."
else
 echo "Fail."
fi


