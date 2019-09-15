#!/bin/bash

for app in /Applications/*.app; do
     echo "$app"
     echo "${app##*/}"
     echo "$(defaults read "$app"/Contents/Info.plist CFBundleShortVersionString)"
done