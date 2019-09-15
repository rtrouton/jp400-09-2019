#!/bin/bash

# Get MAC address for en0

networksetup -getmacaddress Wi-Fi | awk '{print $3}' | tr [:lower:] [:upper:]