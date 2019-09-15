#!/bin/bash

newUser="username"
newUserPassword="password"

# Create user account using sysadminctl

sysadminctl -AddUser "$newUser" -password ${password}