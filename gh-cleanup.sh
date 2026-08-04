#!/bin/bash
# Clear up disk space on GitHub Actions
# Source: https://github.com/CesiumGS/cesium-unreal/blob/main/.github/workflows/buildApple.yml

brew uninstall google-chrome
sudo rm -rf /Users/runner/Library/Android
sudo rm -rf /Applications/Xcode_14.3.app
sudo rm -rf /Applications/Xcode_14.3.1.app
sudo rm -rf /Applications/Xcode_15.0.1.app
sudo rm -rf /Applications/Xcode_15.0.app
sudo rm -rf /Applications/Xcode_15.1.0.app
sudo rm -rf /Applications/Xcode_15.1.app
sudo rm -rf /Applications/Xcode_15.2.0.app
sudo rm -rf /Applications/Xcode_15.2.app
sudo rm -rf /Applications/Xcode_15.3.0.app
sudo rm -rf /Applications/Xcode_15.3.app
sudo rm -rf /Applications/Xcode_15.4.0.app
sudo rm -rf /Applications/Xcode_15.4.app
sudo rm -rf /Applications/Xcode_16.0.0.app
sudo rm -rf /Applications/Xcode_16.0.app

