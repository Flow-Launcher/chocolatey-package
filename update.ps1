import-module au

$releases = 'https://github.com/Flow-Launcher/Flow.Launcher/releases'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $downloadPage = Invoke-WebRequest -Uri $releases

    $url = $downloadPage.Links | ? href -match '\.exe$' | % href | select -First 1
	$url = 'https://github.com' + $url
	
    $version = $url -split '/' | select -Last 1 -Skip 1

    $Latest = @{ URL64 = $url; Version = $version }

    return $Latest
}

update -ChecksumFor 64