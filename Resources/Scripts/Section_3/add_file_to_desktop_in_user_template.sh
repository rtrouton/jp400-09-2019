#!/bin/bash

error="0"

for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    /usr/bin/touch "${USER_TEMPLATE}"/Desktop/FileOnDesktop.txt
  done

exit "$error"