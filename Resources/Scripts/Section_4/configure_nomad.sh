#!/bin/bash

 # The script applies the NoMAD settings to each user template folder

AD_Domain="company.com"
Kerberos_Realm="COMPANY.COM"

 for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.trusourcelabs.NoMAD ADDomain $AD_Domain
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.trusourcelabs.NoMAD KerberosRealm $Kerberos_Realm
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.trusourcelabs.NoMAD RenewTickets -bool TRUE
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
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.trusourcelabs.NoMAD ADDomain $AD_Domain
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.trusourcelabs.NoMAD KerberosRealm $Kerberos_Realm
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.trusourcelabs.NoMAD RenewTickets -bool TRUE
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.trusourcelabs.NoMAD.plist
      fi
    fi
  done