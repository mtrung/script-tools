#!/bin/bash
# Author: Trung Vo

echo "Make Finder to show all files including hidden files"
defaults write com.apple.finder AppleShowAllFiles YES

echo "Restart Finder"
killall Finder /System/Library/CoreServices/Finder.app
