#!/bin/bash

# Get boot time in epoch time then converts it to
# a human-readable date format

bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)
formattedTime=$(date -jf %s "$bootTime" "+%F %T")

echo "<result>$formattedTime</result>"

