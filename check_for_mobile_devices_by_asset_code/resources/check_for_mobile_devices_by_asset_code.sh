#!/bin/bash

# This script does the following:
#
# 1. Requests asset code for a mobile device from Jamf Pro using the API using encrypted credentials.
# 2. Checks for all mobile devices that match that asset code (may be more than one.)
# 3. Displays dialog reporting how many mobile devices matched the asset code.
# 4. Offers the user an option of generating a report on all devices that matched the asset code.
#

error=0

function DecryptString() {
echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}

EncryptedString="U2FsdGVkX1+1nTgI0CtcIWeucYoiUzsRzEiQKmbBKDQ="
Salt="b59d3808d02b5c21"
Passphrase="21899c3d8247dce72ad190d9"

jamfpro_username="jamfproadmin"
jamfpro_password=$(DecryptString "${EncryptedString}" "${Salt}" "${Passphrase}")
jamfpro_url="https://jamf.pro.server.here:8443"

# Delete example: curl -su "$jamfpro_username":"$jamfpro_password" "$jamfpro_url"/JSSResource/computers/id/3000 -X DELETE
# Get example: curl -su "$jamfpro_username":"$jamfpro_password" -H "Accept: text/xml" "$jamfpro_url"/JSSResource/computers -X GET
# Put example: curl -su "$jamfpro_username":"$jamfpro_password" -H "content-type: application/xml" "$jamfpro_url"/JSSResource/computers/id/3000 -X PUT -d "<computer><location><username>Jordan</username></location></computer>"
# Post example: curl -su "$jamfpro_username":"$jamfpro_password" -H "content-type: application/xml" "$jamfpro_url"/JSSResource/computers/id/3000 -X PUT -d "<computer><location><username>Jordan</username></location></computer>"

assetTag=$(osascript << EOF
text returned of (display dialog "Hello, please enter your mobile device asset tag" default answer "JS100000" buttons {"OK"} default button 1)

EOF)

MobileDevice_asset_list=$(curl -su "$jamfpro_username:$jamfpro_password" -H "Accept: application/xml" "$jamfpro_url"/JSSResource/mobiledevices/match/$assetTag)

MobileDeviceIDList=$(echo "$MobileDevice_asset_list" | xpath "//id" 2>/dev/null)

MobileDeviceID=$(echo "$MobileDeviceIDList" | grep -Eo "[0-9]+")

deviceCount=$(echo "$MobileDeviceID" | wc -l | awk '{$1=$1};1')

deviceMessage=$(echo "This many devices match this asset code: $deviceCount")

jamf displayMessage -message "$deviceMessage"

saveReport=$(osascript << EOF
set the answer to the button returned of (display dialog "Do you want to save a report?" buttons {"Save", "Cancel"}  default button 1)

EOF)

echo "$saveReport"

if [[ "$saveReport" = "Save" ]]; then

# Create .csv file

report_file="/tmp/device_report-$(date +%s).csv"

if [[ ! -f "$report_file" ]]; then
   touch "$report_file"
fi

  for MDAsset in ${MobileDeviceID}; do

    FormattedMobileDevice=$(curl -su "$jamfpro_username":"$jamfpro_password" -H "Accept: application/xml" "$jamfpro_url/JSSResource/mobiledevices/id/$MDAsset" -X GET | xmllint --format - )
    DeviceName=$(echo "$FormattedMobileDevice" | xpath "/mobile_device/general/name/text()" 2>/dev/null | sed -e 's|:|(colon)|g' -e 's/\//\\/g')
    DeviceUsername=$(echo "$FormattedMobileDevice" | xpath "/mobile_device/location/username/text()" 2>/dev/null | sed -e 's|:|(colon)|g' -e 's/\//\\/g')
    DeviceDepartment=$(echo "$FormattedMobileDevice" | xpath "/mobile_device/location/department/text()" 2>/dev/null | sed -e 's|:|(colon)|g' -e 's/\//\\/g')
    DeviceSerialNumber=$(echo "$FormattedMobileDevice" | xpath "/mobile_device/general/serial_number/text()" 2>/dev/null | sed -e 's|:|(colon)|g' -e 's/\//\\/g')

    echo "$DeviceName,$DeviceUsername,$DeviceDepartment,$DeviceSerialNumber" >> "$report_file"

  done

  reportMessage=$(echo "Your report is located at the following location: $report_file")
  jamf displayMessage -message "$reportMessage"
else
  echo "No report requested."
fi

exit $error