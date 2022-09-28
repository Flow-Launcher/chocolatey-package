import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64bit\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $downloadPage = Invoke-WebRequest -Uri 'https://api.github.com/repos/flow-launcher/flow.launcher/releases/latest'

    $downloadPage.Content -match 'tag_name":"v(.*)","target'

    $version = $Matches[1]

    $url = 'https://github.com/Flow-Launcher/Flow.Launcher/releases/download/v' + $version + '/Flow-Launcher-Setup.exe'

    $Latest = @{ URL64 = $url; Version = $version }

    return $Latest
}

update -ChecksumFor 64 -NoCheckChocoVersion $true
