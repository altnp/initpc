Write-Header "Setup Github"

try {
    if (Confirm-Action "Would you like to signin to GitHub CLI") {
        gh auth login --web
    }

    if (Confirm-Action "Would you like to install GitHub Copilot CLI") {
        gh extension install github/gh-copilot
    }

}
catch {
    Write-Output "Failed to configure GitHub and Azure DevOps: $_" -ForegroundColor Yellow
}

Pause
