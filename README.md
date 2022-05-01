# chocolatey-package
Repo for Flow Launcher's Chocolatey package

[![AutoUpdate](https://github.com/Flow-Launcher/chocolatey-package/actions/workflows/update_publish.yaml/badge.svg?branch=main)](https://github.com/Flow-Launcher/chocolatey-package/actions/workflows/update_publish.yml)

## Automatic update
When a new release is published by Flow Launcher, this repo's GitHub Action will push the new version to Chocolatey within 24 hours.

## Build package 
choco pack .\flow-launcher\flow-launcher.nuspec

## Install from local
choco install flow-launcher -source .
