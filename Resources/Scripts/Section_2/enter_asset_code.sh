#!/bin/bash

userValue=$(osascript << EOF
text returned of (display dialog "Hello, please enter your asset tag" default answer "AT0000" buttons {"OK"} default button 1)

EOF)

jamf recon -assetTag "$userValue"