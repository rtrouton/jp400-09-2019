#!/bin/bash

userName=$(id -nu)

for groupName in $(dscl . list /groups); do
    groupMembers=$(dseditgroup -o checkmember -o "$userName" "$groupName" | grep yes)
    echo "$groupMembers" | awk '{print $7}' | grep -Ev "^$"
done