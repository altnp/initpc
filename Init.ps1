$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$($myInvocation.MyCommand.Definition)`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    exit
}

try {
    Push-Location

    Get-ChildItem -Path ".\Scripts\utils\" -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }

    . .\Windows\Disable-Computer-Sleep.ps1
    . .\Windows\Configure-Ssh-Key.ps1
    . .\Windows\Configure-Windows-Features.ps1
    . .\Windows\Install-Programs.ps1
    Refresh-Path
    . .\Windows\Configure-PowershellCore.ps1
    . .\Windows\Configure-Package-Sources.ps1
    . .\Windows\Configure-SourceControl.ps1
    . .\Windows\Configure-NerdFonts.ps1
    . .\Windows\Configure-Windows-Settings.ps1
    . .\Windows\Configure-NetworkSettings.ps1
    . .\Windows\Configure-AutoHotKey.ps1
    Refresh-Path
    . .\Windows\Configure-Dotfiles.ps1

    . .\Windows\Enable-Computer-Sleep.ps1

    Write-Host "`n`n`Restart required. After restarting, continue with Init-Wsl.ps1" -ForegroundColor Yellow
    Write-Host "!!!ENSURE GIT HAS NOT CHANGED LINE ENDINGS ON THE SH SCRIPTS IN THIS REPO TO CRLF!!!" -ForegroundColor Red
    Pause

}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
finally {
    Pop-Location
}
