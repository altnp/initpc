Write-Header "Setup Github and Azure Devops"

try {
    if (Confirm-Action "Would you like to signin to GitHub CLI") {
        gh auth login --web
    }

    if (Confirm-Action "Would you like to install GitHub Copilot CLI") {
        gh extension install github/gh-copilot
    }

    Write-Host "Signin to Azure CLI"
    if (Confirm-Action "Would you like to signin to Azure CLI") {
        Write-Host "Installing Azure Devops CLI Extension"
        az extension add --name azure-devops
        try {
            $path = "$env:USERPROFILE\.azure\cliextensions\azure-devops"
            $me = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
            icacls $path /setowner $me /T /C *> $null
            icacls $path /grant ($me + ":(OI)(CI)F") /T /C *> $null
        }
        catch {
            Write-Host "Failed to update permissions for Azure DevOps CLI extension. Please uninstall and reinstall as non-Administrator."
        }

        az login
        az config set extension.dynamic_install_allow_preview=true
        az devops configure --defaults organization=https://dev.azure.com/tcetra/
    }
}
catch {
    Write-Output "Failed to configure GitHub and Azure DevOps: $_" -ForegroundColor Yellow
}

Pause
