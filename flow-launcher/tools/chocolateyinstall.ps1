﻿$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64bit   = 'https://github.com/Flow-Launcher/Flow.Launcher/releases/download/v1.12.1/Flow-Launcher-Setup.exe' 

If (Test-Path $env:LOCALAPPDATA\FlowLauncher\Flow.Launcher.exe){
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$env:LocalAppData\FlowLauncher\Flow.Launcher.exe").FileVersion
	If (Test-Path $env:LOCALAPPDATA\FlowLauncher\app-$version\UserData){
		throw [System.InvalidOperationException] "Installation can not continue because you are currently running Flow Launcher portable mode, this will erase your user data. Go to settings and disable portable mode."
	}	
}

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'exe' 
  url64bit        = $url64bit
  softwareName    = 'Flow-Launcher*'   
  checksum64      = 'c00e02203f15381b55adb46e44e57e4ea00990f25d4b9425e5bb1d6650133883'
  checksumType64  = 'sha256'
  silentArgs      = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" 
  validExitCodes  = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
