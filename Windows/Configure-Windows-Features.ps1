Write-Header "Setting up Windows"

try {
    winget configure -f .\Scripts\Windows\Configs\windows-features.winget --accept-configuration-agreements --nowarn

    Write-Host "Enable Hyper-V"
    $hyperv = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
    if ($hyperv.State -ne 'Enabled') {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart
    }
    else {
        Write-Host "Hyper-V is already enabled."
    }
}
catch {
    Write-Output "Failed to configure Windows features: $_" -ForegroundColor Yellow
}

Pause
