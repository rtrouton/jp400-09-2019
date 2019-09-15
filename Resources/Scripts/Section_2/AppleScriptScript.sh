#!/bin/bash

osascript >/dev/null 2>&1 <<-EOF
tell application id "com.apple.systemevents"
   set myMsg to "Hello World! Do you want to click OK?"
   set theResp to display dialog myMsg buttons {"Cancel", "OK"} default button 2 
end tell

# Following is not really necessary. Cancel returns 1 and OK 0 ...
if button returned of theResp is "Cancel" then
   return 1
end if
EOF

# Check status of osascript
if [ "$?" != "0" ] ; then
   echo "User aborted. Exiting..."
   exit 1
fi

# Check status of osascript
if [ "$?" = "0" ] ; then
   echo "User clicked OK! Celebrate!"
fi