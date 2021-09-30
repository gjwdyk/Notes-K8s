#!/bin/bash -xe

UpGradeResult=/config/UpgradeResult

if [[ `cat $UpGradeResult` =~ ^([0-9]{14} Custom Configuration Finished \.)$ ]] ; then
 echo "`cat $UpGradeResult`"
else
 echo "`date +%Y%m%d%H%M%S` Status Check Fail ."
fi


