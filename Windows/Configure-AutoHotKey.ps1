Write-Header "Configuring AutoHotKey"

Write-Host "Creating startup task for AHK Utilities"
$batContent = @"
@echo off
echo Starting AHK Utilities...
Start "" "%USERPROFILE%\.ahk\utilities.ahk"
"@

$startupFolder = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programs\Startup')
$batFilePath = "$startupFolder\ahkUtilsStartup.bat"

if (-not (Test-Path $batFilePath)) {
    $batContent | Out-File -Path $batFilePath -Encoding ASCII
}
else {
    Write-Host "Startup batch file for AHK Utilities already exists" -ForegroundColor Yellow
}

Pause
