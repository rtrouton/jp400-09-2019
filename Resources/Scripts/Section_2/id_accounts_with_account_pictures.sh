#!/bin/bash

alllocalusers=( $(/usr/bin/dscl . list /Users UniqueID | awk '{print $1}') )
 
# Get length of the array

tLen=${#alllocalusers[@]}

echo "Found ${tLen} user accounts."
 
# Use for loop to read all usernames and check for pictures

for (( i=0; i<${tLen}; i++ )); do
    local_username=$(/usr/bin/dscl . -read /Users/"${alllocalusers[$i]}" RecordName | awk '{print $2}')
    userphoto=$(/usr/bin/dscl . -read /Users/"${alllocalusers[$i]}" JPEGPhoto)
    if [[ -n "$userphoto" ]]; then
       echo "$local_username has an account picture"
    fi
done
       