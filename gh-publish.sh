#!/bin/bash
set -e
ZIP_FILE=Proton-$(date +%d%m%y)-macOS-x86_64.zip
cd Proton/build/build*/redist/
zip -ry $ZIP_FILE .
cd -
gh release create $(date '+%d-%b-%y') -t "Release-$(date '+%d-%b-%y')" --notes "Release $(date '+%d %b %y')" Proton/build/build*/redist/$ZIP_FILE
