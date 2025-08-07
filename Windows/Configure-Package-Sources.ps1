Write-Header "Adding TCETRA NPM Registry"

try {
    if (-not (npm list -g vsts-npm-auth --depth=0 | Select-String 'vsts-npm-auth')) {
        npm install -g vsts-npm-auth --registry https://registry.npmjs.com --always-auth false
    }
    else {
        Write-Host "vsts-npm-auth is already installed globally." -ForegroundColor Yellow
    }

    pnpm setup;
    $env:PNPM_HOME = [System.Environment]::GetEnvironmentVariable('PNPM_HOME', 'User')
    Refresh-Path


    if (-not (pnpm list -g vsts-npm-auth | Select-String 'vsts-npm-auth')) {
        pnpm install -g vsts-npm-auth
    }
    else {
        Write-Host "vsts-npm-auth is already installed globally for pnpm." -ForegroundColor Yellow
    }

    Write-Host "Signin to Nuget Azure Artifacts"
    Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-artifacts-credprovider.ps1) }"
    New-Item -ItemType Directory -Path .\azureArtifactLogin
    Set-Content -Path .\azureArtifactLogin\NuGet.Config -Value '<?xml version="1.0" encoding="utf-8"?><configuration><packageSources><clear /><add key="Tcetra-Packages" value="https://pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/nuget/v3/index.json" /></packageSources></configuration>'
    dotnet new web -o .\azureArtifactLogin
    dotnet restore .\azureArtifactLogin --interactive
    Remove-Item -Recurse -Force .\azureArtifactLogin
}
catch {
    Write-Output $_
}

Pause
