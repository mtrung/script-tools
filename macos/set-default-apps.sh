#!/bin/bash
# Author: Trung Vo
# Description: Changes default apps for extensions

# $1: command/tool to check & install
# $2 [optional]: command to install
toolchain_require() {
  if [ -z "$1" ]; then return; fi
  if [ -z "$(which $1)" ]; then
    if [ -z "$2" ]; then echo - Install $1 ; brew install $1
    else echo - Install $1 from package $2 ; eval "$2"; fi
  else echo "- $1 already installed"; fi
}
toolchain_require duti

if [ -z "$1" ]; then printf "\nDisplay info only. To change:\nType: $0 set\n\n"; fi

count=0
cat default-apps.txt | grep . |
while IFS=$':' read bundle_id extension ; do
  let "count+=1"
  # grep to see if Bundle ID exists, sending stdout to /dev/null
  /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump | grep $bundle_id > /dev/null  
  # exit status (0=success & 1=failure)
  status=$?
  # If exit status failed, skip & continue to next item; if not, change default app for extension
  if (( $status == 1 )); then
    echo "- $bundle_id doesn't exist!"
    continue
  else
    if [ -n "$1" ]; then
      echo "- Changing .$extension to open with $bundle_id"
      duti -s $bundle_id .$extension all
    fi
    printf "=== #$count: \n.$extension uses "
    duti -x $extension    
  fi
done
