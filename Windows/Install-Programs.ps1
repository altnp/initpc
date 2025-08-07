Write-Header "Installing Programs"

try {
    winget configure -f .\Windows\Configs\programs.winget --accept-configuration-agreements --nowarn

    # Missing from WinGet
    choco install sqltoolbelt -y
    choco install mingw -y
    choco install android-sdk -y

    nuget sources Add -Name "nuget.org" -Source "https://api.nuget.org/v3/index.json";
    nuget sources Enable -Name "nuget.org"
    dotnet tool install Octopus.DotNet.Cli -g

    python -m pip install --user pipx
    python -m pipx ensurepath
    Refresh-Path;
    pipx install sqlfluff
}
catch {
    Write-Host "Failed to install base programs: $_" -ForegroundColor Yellow
}

try {
    # Teams for Business (Not on Choco)
    Write-Host "Installing Microsoft Teams for Buisness" -ForegroundColor Green
    $teamsDownloadUrl = "https://go.microsoft.com/fwlink/?linkid=2187327&Lmsrc=groupChatMarketingPageWeb&Cmpid=directDownloadWin64&clcid=0x409&culture=en-us&country=us"
    $teamsDestPath = "C:\TeamsInstaller.exe"
    Invoke-WebRequest -Uri $teamsDownloadUrl -OutFile $teamsDestPath
    Start-Process -FilePath $teamsDestPath -Args "/s" -NoNewWindow -Wait

    while (Get-Process "TeamsInstaller" -ErrorAction SilentlyContinue) {
        Write-Host "Waiting for Teams installation to complete..."
        Start-Sleep -Seconds 5
    }

    Remove-Item -Path $teamsDestPath
    Write-Host "Microsoft Teams for Buisness has been installed."
}
catch {
    Write-Host "Failed to install Microsoft Teams for Buisness: $_" -ForegroundColor Yellow
}

Refresh-Path

Pause
