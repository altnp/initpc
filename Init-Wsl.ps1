$ErrorActionPreference = "Stop"
$ProgressPreference = 'SilentlyContinue'

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$($myInvocation.MyCommand.Definition)`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    exit
}

Get-ChildItem -Path ".\Scripts\utils\" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

Write-Header "Installing WSL - Arch..."
wsl --install -d ArchLinux --name Arch --no-launch
wsl --set-default Arch

Write-Host "`nSetup Arch User"
$username = Read-Host "Enter the username to create for Arch WSL"

wsl -d Arch -- bash -c "
  pacman -Sy --noconfirm sudo && \
  useradd -m -G wheel $username && \
  echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers && \
  chmod 440 /etc/sudoers && \
  echo ''
  while true; do \
    passwd $username && break; \
    echo 'Password not set. Please try again.'; \
  done
"
wsl --manage Arch --set-default-user $username

Write-Host "`nCreating startup task to keep WSL running"
$batContent = @"
@echo off
echo "Starting WSL..."
wsl --exec dbus-launch true
"@

$startupFolder = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')
$batFilePath = "$startupFolder\wslStartup.bat"
$batContent | Out-File -Path $batFilePath -Encoding ASCII

Write-Host "Setting WSL_HOME environment variable"
$homeDir = (wsl echo ~) -replace '/', '\'
[System.Environment]::SetEnvironmentVariable("WSL_HOME", "\\wsl.localhost\Arch$homeDir", "User")

wsl -e bash init-wsl.sh -d Arch

Start-Process -FilePath $batFilePath
