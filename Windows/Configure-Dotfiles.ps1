Write-Header "Cloning dotfiles..."

try {
    if (-not (Test-Path "$env:USERPROFILE\.local\share\chezmoi")) {

        chezmoi init git@github.com:altnp/dotfiles.git
        chezmoi apply

        $reposDir = $(chezmoi data | ConvertFrom-Json).reposDir

        New-Item -ItemType Directory -Path $reposDir -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $reposDir 'Pvt') -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $reposDir 'OSS') -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $reposDir 'Local') -Force | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $reposDir 'Yipit') -Force | Out-Null
    }
    else {
        Write-Host "Dotfiles already cloned" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Failed to configure dotfiles: $_" -ForegroundColor Yellow
}

Pause
