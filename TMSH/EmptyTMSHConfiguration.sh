#!/bin/bash



#╔════════════════════╗
#║   PRE Requisites   ║
#╚════════════════════╝
#
#The following to be completed before running the TMSH scripts below:
#
#֍ Interface
#֍ VLAN
#֍ Self IP Address
#֍ Default Route
#֍ License and Provisioning
#֍ NTP
#֍ DNS



#╔═════════════════════════════════════╗
#║   Just Showing System Information   ║
#╚═════════════════════════════════════╝

echo "This TMSH Commands File is practically empty, just showing some system information."

declare -a tmsh=()
tmsh+=(
 "tmsh show sys software"
 "tmsh show sys license"
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



#╔═╦═════════════════╦═╗
#║ ║                 ║ ║
#╠═╬═════════════════╬═╣
#║ ║ End of Document ║ ║
#╠═╬═════════════════╬═╣
#║ ║                 ║ ║
#╚═╩═════════════════╩═╝


