#!/bin/bash

# Disable "Capitalize words automatically" in System Preferences: Keyboard: Text

defaults write "$HOME"/Library/Preferences/.GlobalPreferences.plist NSAutomaticCapitalizationEnabled -bool false