Write-Header "Setting up Windows"

winget configure -f .\Windows\Configs\windows-settings.winget --accept-configuration-agreements --nowarn --verbose

if (Confirm-Action "Remove Desktop Shortcuts?") {
    try {
        $desktopPath = [System.Environment]::GetFolderPath('Desktop')
        Get-ChildItem "$desktopPath\*.lnk" | Remove-Item -Confirm:$false
        $publicDesktopPath = "C:\Users\Public\Desktop"
        Get-ChildItem "$publicDesktopPath\*" | Remove-Item -Recurse -Confirm:$false
    }
    catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
    }
}

if (Confirm-Action "Cleanup Start Menu?") {
    try {
        Write-Host "Requires Manual Configuration" -ForegroundColor Yellow
        Start-Process "ms-settings:personalization-start"
        Pause
    }
    catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
    }
}

Pause
