#!/bin/bash
# Clear up disk space on GitHub Actions

sudo rm -rf /Users/runner/Library/Android
xcrun simctl runtime delete all
: '
sudo rm -rf /Applications/Xcode_16.app
sudo rm -rf /Applications/Xcode_16.1.app
sudo rm -rf /Applications/Xcode_16.2.app
sudo rm -rf /Applications/Xcode_16.3.app
sudo rm -rf /Applications/Xcode_26.0.1.app
sudo rm -rf /Applications/Xcode_26.1.1.app
sudo rm -rf /Applications/Xcode_26.2.app
sudo rm -rf /Applications/Xcode_26.3.app
'
