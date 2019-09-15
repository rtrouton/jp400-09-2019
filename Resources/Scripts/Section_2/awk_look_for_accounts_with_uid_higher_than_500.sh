#!/bin/bash

# Find the account names of all accounts with a UID higher than 500

dscl . list /Users UniqueID | awk '$2>500{print $1}'