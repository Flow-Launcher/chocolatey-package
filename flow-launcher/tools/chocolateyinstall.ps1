$ErrorActionPreference = 'Stop'; 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64bit   = 'https://github.com/Flow-Launcher/Flow.Launcher/releases/download/v1.9.0/Flow-Launcher-Setup.exe' 

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
  checksum64      = '0D05A0BE805BA97C1AE59096BF2F970029A7A9E714B27A25DA8764CADA435305'
  checksumType64  = 'sha256'
  silentArgs      = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" 
  validExitCodes  = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
