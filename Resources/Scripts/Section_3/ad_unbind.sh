#!/bin/bash

#
# Script to force AD unbinding
#

username="$4"
password="$5"

# If the username or password are missing, using a bogus user and password
# also works since dsconfigad wants a specified user account but doesn't 
# check to see if its valid if a force unbind is used.

if [[ -z "$username" ]]; then 
   forceunbind="yes"
   username="nousernamehere"
fi

if [[ -z "$password" ]]; then
   forceunbind="yes" 
   password="nopasswordhere"
fi

# Determine OS version

osvers_major=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $1}')
osvers_minor=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')

# Unbinding from Active Directory on 10.6.x and earlier

# Use dsconfigad to force AD unbinding. Using a bogus user and password
# since dsconfigad wants a specified user account.

if [[ ${osvers_major} -eq 10 ]] && [[ ${osvers_minor} -lt 7 ]]; then

  if [[ "$forceunbind" = "yes" ]]; then  
      /bin/echo "Unbinding from Active Directory on 10.6.x and earlier."
      /usr/sbin/dsconfigad -f -r -u "$username" -p "$password"
   else
      /bin/echo "Unbinding from Active Directory on 10.6.x and earlier."
      /usr/sbin/dsconfigad -r -u "$username" -p "$password"
    fi 

fi


# Unbinding from Active Directory on 10.7.x and later

if [[ ${osvers_major} -eq 10 ]] && [[ ${osvers_minor} -ge 7 ]]; then
  
  if [[ "$forceunbind" = "yes" ]]; then  
      /bin/echo "Unbinding from Active Directory on 10.7.x and later."
      /usr/sbin/dsconfigad -force -remove -u "$username" -p "$password"
   else
      /bin/echo "Unbinding from Active Directory on 10.7.x and later."
      /usr/sbin/dsconfigad -remove -u "$username" -p "$password"
    fi 

fi