#!/bin/bash
ZIP_FILE=Proton-$(date +%d%m%y)-macOS-x86_64.zip
cd build/build*/redist/*
zip -r $ZIP_FILE .
gh release create --notes "Release $(date +%d %b %y)" $ZIP_FILE
cd -