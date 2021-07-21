#!/bin/bash

echo "HC's Mark --------->>>>>>>>> Starting UpGrade bash script."
source /config/cloud/aws/onboard_config_vars

DEBUG=ON

Log_File=/var/log/cloud/aws/install.log
UpGradeImageName_File=/config/UpgradeImageFileName
UpGradeResult=/config/UpgradeResult

Log_Wait_Period="3m 33s"
UpGrade_ShortWait_Period="22s"
UpGrade_LongWait_Period="2m 2s"



while ( ! [ -f "$Log_File" ] ); do
 echo "`date +%Y%m%d%H%M%S` Wait for $Log_File . Sleep for $Log_Wait_Period ."
 sleep $Log_Wait_Period
done

while ( ! ( ( grep "Sending signal" "$Log_File" | grep "PASSWORD_CREATED" ) && ( grep "Sending signal" "$Log_File" | grep "ADMIN_CREATED" ) && ( grep "Sending signal" "$Log_File" | grep "NETWORK_CONFIG_DONE" ) && ( grep "Sending signal" "$Log_File" | grep "ONBOARD_DONE" ) && ( grep "Sending signal" "$Log_File" | grep "CUSTOM_CONFIG_DONE" ) && ( grep "Sending signal" "$Log_File" | grep "PASSWORD_REMOVED" ) && ( grep "exited with code 0" "$Log_File" | grep "f5-rest-node" ) && ( grep "exited with code 0" "$Log_File" | grep "createUser.sh" ) && ( grep "exited with code 0" "$Log_File" | grep "custom-config.sh" ) && ( grep "exited with code 0" "$Log_File" | grep "rm-password.sh" ) ) ); do
# while ( ! ( ( grep "Sending signal" "$Log_File" | grep "NETWORK_CONFIG_DONE" ) && ( grep "Sending signal" "$Log_File" | grep "ONBOARD_DONE" ) && ( grep "Sending signal" "$Log_File" | grep "CUSTOM_CONFIG_DONE" ) && ( grep "exited with code 0" "$Log_File" | grep "custom-config.sh" ) ) ); do
 echo "`date +%Y%m%d%H%M%S` Wait for Other Processes to Finish . Sleep for $Log_Wait_Period ."
 sleep $Log_Wait_Period
done



printf "$UpGradeVolume_Value" > "$UpGradeVolume_File"
"/config/cloud/aws/node_modules/@f5devcentral/f5-cloud-libs/scripts/waitForMcp.sh"
echo "`date +%Y%m%d%H%M%S` Checking PreConditions. Wait for $UpGrade_ShortWait_Period ."
sync
sleep $UpGrade_ShortWait_Period
if [ "$DEBUG" == "ON" ] ; then
 echo "Value of UpGradeVolume_Value : $UpGradeVolume_Value"
 echo "cat $UpGradeVolume_File :"
 echo "`cat $UpGradeVolume_File`"
 echo "tmsh show sys software :"
 echo "`tmsh show sys software`"
fi

if ( tmsh show sys software | grep `cat $UpGradeVolume_File` | grep "complete" ); then
 echo "`date +%Y%m%d%H%M%S` Unit had been UpGraded ."

 echo "`date +%Y%m%d%H%M%S` SSMTP Configurations ."
 cp --force /etc/pki/tls/certs/ca-bundle.crt /etc/ssmtp/ca-bundle.crt
 chmod 666 /etc/ssmtp/ca-bundle.crt
 cp --force /config/ssmtp/ArchiveSSMTPConfiguration /etc/ssmtp/ssmtp.conf
 cp --force /config/ssmtp/eMailNotificationRecipient /etc/ssmtp/eMailNotificationRecipient
 cp --force /config/crontab /etc/crontab
 cp --force /config/anacrontab /etc/anacrontab
 echo "@reboot                                             root      /bin/sudo /bin/cp --force /config/ssmtp/ArchiveSSMTPConfiguration /etc/ssmtp/ssmtp.conf" >> /etc/crontab
 echo "*/9         *         *         *         *         root      /bin/sudo /bin/bash /config/ClearFlags" >> /etc/crontab
 echo "1           9   anacron.daily     /bin/sudo /bin/bash /config/RotateLog" >> /etc/anacrontab
 echo "3          22   anacron.daily     /bin/sudo /bin/bash /config/lidsa/ClearLidsaFlags" >> /etc/anacrontab
 if [ "$DEBUG" == "ON" ] ; then
  echo "cat /config/lidsa/LoremIpsumDolorSitAmet :"
  echo "`cat /config/lidsa/LoremIpsumDolorSitAmet`"
 fi

 #if [[ `cat $UpGradeImageName_File` =~ ^(BIGIP\-)((([0-9]+)\.)+)([0-9]+)\-((([0-9]+)\.)+)([0-9]+)\.iso$ ]]; then
 # echo "`date +%Y%m%d%H%M%S` Preparing to ReLicense the Unit. Wait for $UpGrade_ShortWait_Period ."
 # sync
 # sleep $UpGrade_ShortWait_Period
 # /bin/sudo /bin/bash /config/lidsa/BigIPSendMailLidsa ReLicense_On_UpGrade_Procedure '' 'ReLicense on Upgrade'
 #else
 # echo "`date +%Y%m%d%H%M%S` Value of $UpGradeImageName_File : `cat $UpGradeImageName_File` does NOT match Regular Expression ."
 #fi
 echo "`date +%Y%m%d%H%M%S` Preparing to Continue with Other Configurations. Wait for $UpGrade_ShortWait_Period ."
 sync
 sleep $UpGrade_ShortWait_Period
 echo "`date +%Y%m%d%H%M%S` Custom TMSH Configuration After UpGrade ."
 declare -a tmsh=()
 tmsh+=(
  "tmsh modify auth user admin password `cat /config/BigIPAdminPassword`"
  "tmsh save /sys config"
 )
 for CMD in "${tmsh[@]}"; do
  "/config/cloud/aws/node_modules/@f5devcentral/f5-cloud-libs/scripts/waitForMcp.sh"
  if $CMD; then
   echo "command $CMD successfully executed."
  else
   error_exit "$LINENO: An error has occurred while executing $CMD. Aborting!"
  fi
 done

 echo "Upgrade Big-IP : $UpgradeBigIP"
 if [[ $UpgradeBigIP == "No" ]]; then
  echo "Skip Pre-UpGrade TMSH Commands"
 else
  /bin/sudo /bin/bash /config/AS3Configuration.sh
  /bin/sudo /bin/bash /config/TMSHPostCommands.sh
  echo "`date +%Y%m%d%H%M%S` Custom Configuration Finished ." | tee -a $UpGradeResult
 fi



else
 echo "`date +%Y%m%d%H%M%S` Unit to be UpGraded ."

 echo "`date +%Y%m%d%H%M%S` SSMTP Configurations ."
 echo "AuthUser=`cat /config/ssmtp/SMTPUserID`" >> /config/ssmtp/ArchiveSSMTPConfiguration
 echo "AuthPass=`cat /config/ssmtp/SMTPUserPassword`" >> /config/ssmtp/ArchiveSSMTPConfiguration
 cp --force /etc/pki/tls/certs/ca-bundle.crt /etc/ssmtp/ca-bundle.crt
 chmod 666 /etc/ssmtp/ca-bundle.crt
 cp --force /config/ssmtp/ArchiveSSMTPConfiguration /etc/ssmtp/ssmtp.conf
 cp --force /config/ssmtp/eMailNotificationRecipient /etc/ssmtp/eMailNotificationRecipient
 if [ ! -d /config/Flags ]; then
  mkdir /config/Flags
 fi
 cp --force /config/crontab /etc/crontab
 cp --force /config/anacrontab /etc/anacrontab
 echo "@reboot                                             root      /bin/sudo /bin/cp --force /config/ssmtp/ArchiveSSMTPConfiguration /etc/ssmtp/ssmtp.conf" >> /etc/crontab
 echo "*/9         *         *         *         *         root      /bin/sudo /bin/bash /config/ClearFlags" >> /etc/crontab
 echo "1           9   anacron.daily     /bin/sudo /bin/bash /config/RotateLog" >> /etc/anacrontab

 echo "`date +%Y%m%d%H%M%S` Lidsa Configurations ."
 if [ ! -d /config/lidsa ]; then
  mkdir /config/lidsa
  mkdir /config/lidsa/cae
 else
  if [ ! -d /config/lidsa/cae ]; then
   mkdir /config/lidsa/cae
  fi
 fi
 echo "3          22   anacron.daily     /bin/sudo /bin/bash /config/lidsa/ClearLidsaFlags" >> /etc/anacrontab
 awk 'BEGIN{ORS=""} $1=="nameserver" {print $2; exit}' /etc/resolv.conf > /config/lidsa/DNSServer
 printf "`cat /config/lidsa/TemporaryLidsa`" > /config/lidsa/LoremIpsumDolorSitAmet
 if [ "$DEBUG" == "ON" ] ; then
  echo "cat /config/lidsa/TemporaryLidsa :"
  echo "`cat /config/lidsa/TemporaryLidsa`"
  echo "cat /config/lidsa/LoremIpsumDolorSitAmet :"
  echo "`cat /config/lidsa/LoremIpsumDolorSitAmet`"
 fi
 rm --force /config/lidsa/TemporaryLidsa

 echo "`date +%Y%m%d%H%M%S` Custom TMSH Configuration ."
 cat /config/user_alert.archive >> /config/user_alert.conf
 declare -a tmsh=()
 tmsh+=(
  "tmsh modify auth user admin password `cat /config/BigIPAdminPassword`"
  "tmsh modify sys db ui.system.preferences.recordsperscreen value 333"
  "tmsh save /sys config"
 )
 for CMD in "${tmsh[@]}"; do
  "/config/cloud/aws/node_modules/@f5devcentral/f5-cloud-libs/scripts/waitForMcp.sh"
  if $CMD; then
   echo "command $CMD successfully executed."
  else
   error_exit "$LINENO: An error has occurred while executing $CMD. Aborting!"
  fi
 done

 echo "Upgrade Big-IP : $UpgradeBigIP"
 if [[ $UpgradeBigIP == "No" ]]; then
  /bin/sudo /bin/bash /config/TMSHPreCommands.sh
 else
  echo "Skip Pre-UpGrade TMSH Commands"
 fi

 echo "`date +%Y%m%d%H%M%S` UpGrade Process ."
 if [ -f /shared/images/UpgradeImage.iso ] && [ -f /shared/images/UpgradeImage.iso.md5 ] && [[ `cat $UpGradeImageName_File` =~ ^(BIGIP\-)((([0-9]+)\.)+)([0-9]+)\-((([0-9]+)\.)+)([0-9]+)\.iso$ ]]; then
  if [[ $UpgradeBigIP == "No" ]]; then
   echo "`date +%Y%m%d%H%M%S` UpGrade was NOT requested ."
   echo "`date +%Y%m%d%H%M%S` Custom Configuration Finished ." | tee -a $UpGradeResult
  else
   mv /shared/images/UpgradeImage.iso /shared/images/`cat $UpGradeImageName_File`
   mv /shared/images/UpgradeImage.iso.md5 /shared/images/`cat $UpGradeImageName_File`.md5
   cd /shared/images/
   echo "`date +%Y%m%d%H%M%S` Checking Image File Integrity ."
   md5sum --check `cat $UpGradeImageName_File`.md5 > /config/MD5CheckSumResult
   if ( cat /config/MD5CheckSumResult | grep `cat $UpGradeImageName_File` | grep "OK" ); then
    echo "`date +%Y%m%d%H%M%S` Preparing to Install Software Image File. Wait for $UpGrade_ShortWait_Period ."
    sync
    sleep $UpGrade_ShortWait_Period
    tmsh install /sys software image `cat $UpGradeImageName_File` volume `cat $UpGradeVolume_File` create-volume
    tmsh show sys software > /config/MonitorUpgradeVolumeInstallation
    while ( ! ( cat /config/MonitorUpgradeVolumeInstallation | grep `cat $UpGradeVolume_File` | grep "complete" ) ); do
     echo "`date +%Y%m%d%H%M%S` `cat /config/MonitorUpgradeVolumeInstallation`"
     echo "`date +%Y%m%d%H%M%S` Installing Software Image File. Wait for $UpGrade_LongWait_Period ."
     sync
     sleep $UpGrade_LongWait_Period
     tmsh show sys software > /config/MonitorUpgradeVolumeInstallation
     sync
    done
    if ( cat /config/MonitorUpgradeVolumeInstallation | grep `cat $UpGradeVolume_File` | grep "complete" ); then
     echo "`date +%Y%m%d%H%M%S` Preparing to ReBoot from the New Volume. Wait for $UpGrade_ShortWait_Period ."
     sync
     sleep $UpGrade_ShortWait_Period
     tmsh reboot volume `cat $UpGradeVolume_File`
    fi
   else
    echo "`date +%Y%m%d%H%M%S` /shared/images/`cat $UpGradeImageName_File` is CORRUPTED ."
   fi
  fi
 else
  if [ ! -f /shared/images/UpgradeImage.iso ]; then
   echo "`date +%Y%m%d%H%M%S` /shared/images/UpgradeImage.iso does NOT exist ."
  fi
  if [ ! -f /shared/images/UpgradeImage.iso.md5 ]; then
   echo "`date +%Y%m%d%H%M%S` /shared/images/UpgradeImage.iso.md5 does NOT exist ."
  fi
  if ( ! [[ `cat $UpGradeImageName_File` =~ ^(BIGIP\-)((([0-9]+)\.)+)([0-9]+)\-((([0-9]+)\.)+)([0-9]+)\.iso$ ]] ); then
   echo "`date +%Y%m%d%H%M%S` Value of $UpGradeImageName_File : `cat $UpGradeImageName_File` does NOT match Regular Expression ."
  fi
 fi



fi


