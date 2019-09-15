#!/bin/bash

result=$("/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType hud -description "Click OK to run install" -button1 "OK" -button2 "Cancel" -defaultButton 1 -showDelayOptions "0, 300, 3600")

if [[ "$result" == 239 ]]; then
    echo "$result"
    echo "User clicked Cancel."
else
   timeSelected=${result%?}
   buttonClicked=${result: -1}
fi

echo "$timeSelected"
echo "$buttonClicked"
