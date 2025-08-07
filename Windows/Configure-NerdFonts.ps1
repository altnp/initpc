Write-Header "Configure Nerd Fonts"

function Test-FontInstalled {
    param([string]$FontName)
    $fontsPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    $userFontsPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    $fonts = @()
    $userFonts = @()

    try {
        $systemFontProps = Get-ItemProperty -Path $fontsPath -ErrorAction SilentlyContinue
        if ($systemFontProps) {
            $fonts = @($systemFontProps | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name)
        }
    }
    catch {
    }

    try {
        $userFontProps = Get-ItemProperty -Path $userFontsPath -ErrorAction SilentlyContinue
        if ($userFontProps) {
            $userFonts = @($userFontProps | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name)
        }
    }
    catch {
    }

    return ($fonts + $userFonts) -match $FontName
}

function Install-NerdFont {
    param([string]$FontName)
    if (-not (Test-FontInstalled $FontName)) {
        git sparse-checkout add "patched-fonts/$FontName"
        ./install $FontName
    }
}

Write-Host "Installing Popular Nerd Fonts"
try {
    Push-Location
    Set-Location C:\
    git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
    Set-Location nerd-fonts

    Install-NerdFont "FiraCode"
    Install-NerdFont "JetBrainsMono"
    Install-NerdFont "CascadiaCode"

    Set-Location ..
    Remove-Item "nerd-fonts" -r -Force
}
catch {
    Write-Output "Failed to install Nerd Fonts: $_"
}
finally {
    Pop-Location
}

Pause
