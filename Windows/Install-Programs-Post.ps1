Get-ChildItem -Path ".\utils\" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

Write-Header "Installing additional programs"

Refresh-Path;

Write-Host "Installing NPM lts"
nvm install lts
nvm use lts

Write-Host "Installing PNPM & Yarn"
npm install --global corepack@latest

Write-Host "Installing Angular CLI"
npm install -g @angular/cli

Write-Host "Installing Tsx"
npm install -g tsx

Write-Host "Installing Yeoman"
npm install -g yo

Write-Host "Installing VS Code Extensions CLI"
npm install -g vsce

Write-Host "Installing Nx CLI"
npm install -g nx
