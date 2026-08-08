#!/bin/bash
ZIP_FILE=Proton-$(date +%d%m%y)-macOS-x86_64.zip
cd Proton/build/build*/redist/
zip -ry $ZIP_FILE .
cd -
gh release create -t "Release-$(date '+%d-%b-%y')" --notes "Release $(date '+%d %b %y')" Proton/build/build*/redist/$ZIP_FILE
