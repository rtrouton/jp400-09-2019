#!/bin/bash

 # The script adds a EULA text document to each user template folder

 for USER_TEMPLATE in "$3/System/Library/User Template"/*
  do
    /usr/bin/touch "${USER_TEMPLATE}"/Desktop/eula.txt
    /bin/echo "This is your EULA. Do great things." > "${USER_TEMPLATE}"/Desktop/eula.txt
  done

 # The script first checks the existing user folders in /Users
 # for the presence of the Library/Preferences directory.
 #
 # If the directory is not found, it is created and then the
 # EULA document is added.

 for USER_HOME in "$3/Users"/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ]; then
      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]; then
        /usr/bin/touch "${USER_HOME}"/Desktop/eula.txt
        /bin/echo "This is your EULA. Do great things." > "${USER_HOME}"/Desktop/eula.txt
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Desktop/eula.txt
      fi
    fi
  done