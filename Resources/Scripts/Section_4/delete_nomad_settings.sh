#!/bin/bash

 # The script deletes the NoMAD settings in each user template folder

 for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    /bin/rm "${USER_TEMPLATE}"/Library/Preferences/com.trusourcelabs.NoMAD.plist
  done

 # The script first checks the existing user folders in /Users
 # for the presence of the Library/Preferences directory.
 #
 # If the directory is not found, it is created and then the
 # NoMAD settings are applied.

 for USER_HOME in "/Users"/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]; then
      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/rm "${USER_HOME}"/Library/Preferences/com.trusourcelabs.NoMAD.plist
      fi
    fi
  done