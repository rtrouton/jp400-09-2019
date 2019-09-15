#!/bin/bash

function DecryptString() {
echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}

EncryptedString="U2FsdGVkX1+1nTgI0CtcIWeucYoiUzsRzEiQKmbBKDQ="
Salt="b59d3808d02b5c21"
Passphrase="21899c3d8247dce72ad190d9"

jamfpro_username="jamfproadmin"
jamfpro_password=$(DecryptString "${EncryptedString}" "${Salt}" "${Passphrase}")
jamfpro_url="https://jamf.pro.server.here:8443"
serial_number=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')

curl -su "$jamfpro_username":"$jamfpro_password" -H "Accept: text/xml" "$jamfpro_url"/JSSResource/computers/serialnumber/"$serial_number"