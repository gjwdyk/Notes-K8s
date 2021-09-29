#!/bin/bash

PROGNAME=$(basename $0)
function error_exit {
 echo "${PROGNAME}: ${1:-\"Unknown Error\"}" 1>&2
 exit 1
}

echo "Starts to DownLoad and Apply AS3 Configuration File"

source /config/cloud/aws/onboard_config_vars

deployed="no"
url_regex="(http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$"
file_loc="/config/cloud/custom_config_post"
if [[ $DeclarationURLPost =~ $url_regex ]]; then
  response_code=$(/usr/bin/curl -sk -w "%{http_code}" $DeclarationURLPost -o $file_loc)
  if [[ $response_code == 200 ]]; then
    echo "Custom config download complete; checking for valid JSON."
    cat $file_loc | jq .class
    if [[ $? == 0 ]]; then
      response_code=$(/usr/bin/curl -skvvu admin:`cat /config/BigIPAdminPassword` -w "%{http_code}" -X POST -H "Content-Type: application/json" -H "Expect:" https://localhost:${managementGuiPort}/mgmt/shared/appsvcs/declare -d @$file_loc -o /dev/null)
      if [[ $response_code == 200 || $response_code == 502 ]]; then
        echo "Deployment of custom application succeeded."
        deployed="yes"
      else
        echo "Failed to deploy custom application; continuing . . ."
      fi
    else
      echo "Custom config was not valid JSON, continuing . . ."
    fi
  else
    echo "Failed to download custom config; continuing . . ."
  fi
else
  echo "Custom config was not a URL, continuing . . ."
fi

echo "Finish Applying AS3 Configuration File. Deployed : $deployed"
