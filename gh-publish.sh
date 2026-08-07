#!/bin/bash
ZIP_FILE=Proton-$(date +%d%m%y)-macOS-x86_64.zip
cd Proton/build/build*/redist/
zip -ry $ZIP_FILE .
gh release create -t "Release-$(date '+%d-%b-%y')" --notes "Release $(date +%d %b %y)" $ZIP_FILE
cd -
