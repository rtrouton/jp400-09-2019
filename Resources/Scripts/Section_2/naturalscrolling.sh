#!/bin/bash
user=$(stat -f %Su /dev/console)
sudo su - $user -c "/usr/bin/defaults read NSGlobalDomain com.apple.swipescrolldirection"