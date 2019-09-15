#!/bin/bash

jamfpro_username="jamfproadmin"
jamfpro_password="password_goes_here"
jamfpro_url="https://jamf.pro.server.here:8443"
jamfpro_invitation="144908707164604719502384530940997501426"
exit_status="0"

# Download the Jamf binary and install it into /usr/local/jamf/bin/jamf

curl -su "$jamfpro_username":"$jamfpro_password" "$jamfpro_url"/bin/jamf -o /tmp/jamf

mkdir -p /usr/local/jamf/bin/jamf

cp /tmp/jamf /usr/local/jamf/bin/.

chmod 755 /usr/local/jamf/bin/jamf

# Create /usr/local/bin if it doesn't exist

if [[ ! -d "/usr/local/bin" ]]; then
    mkdir -p /usr/local/bin
fi

# Create a symbolic link to the jamf binary in /usr/local/bin

ln -s /usr/local/jamf/bin/jamf /usr/local/bin/jamf

# Create configuration file

jamf createConf -k  -url "$jamfpro_url"

# Enroll in Jamf Pro server

jamf enroll -invitation "$jamfpro_invitation"

exit "$exit_status"

