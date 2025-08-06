Write-Header "Setting up Powershell Core"

try {
    winget configure -f .\Scripts\Windows\Configs\powershell-core.winget --accept-configuration-agreements --nowarn
}
catch {
    Write-Output $_
}

Pause
