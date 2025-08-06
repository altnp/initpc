Write-header "Generating SSH Key for Machine"

New-Alias -Name gitBash -Value "$Env:ProgramFiles\Git\bin\bash.exe"
$sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa"

if (-not (Test-Path $sshKeyPath)) {
    $label = Read-Host "Input SSH Key Label"
    gitbash -c "ssh-keygen -t rsa -b 4096 -C '$label' -N '' -q -f ~/.ssh/id_rsa; \
                eval `$(ssh-agent -s); \
                ssh-add ~/.ssh/id_rsa; \
                clip < ~/.ssh/id_rsa.pub"
    Write-Host "SSH Public Key Copied to Clipboard.." -ForegroundColor Cyan
}
else {
    Write-Host "SSH Key already exists at $sshKeyPath. Skipping key generation." -ForegroundColor Yellow
}

if (Confirm-Action "`nWould you like to import the key into github?") {
    Start-Process "https://github.com/settings/keys"
}

if (Confirm-Action "`nWould you like to import the key into T-CETRA Azure Devops?") {
    Start-Process "https://dev.azure.com/Tcetra/_usersSettings/keys"
}

Pause
