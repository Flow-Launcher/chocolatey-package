# chocolatey-package
Repo for Flow Launcher's Chocolatey package

## Automatic update
When a new release is published by Flow Launcher, this repo's GitHub Action will push the new version to Chocolatey within 24 hours.

## Build package 
choco pack .\flow-launcher\flow-launcher.nuspec

## Install from local
choco install flow-launcher -source .