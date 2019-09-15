#!/bin/bash

set -x

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

Computers_id_list=$(curl -su "$jamfpro_username":"$jamfpro_password" -H "Accept: text/xml" "${jamfpro_url}/JSSResource/computers" -X GET | xpath "//id" 2>/dev/null)

echo "$Computers_id_list"