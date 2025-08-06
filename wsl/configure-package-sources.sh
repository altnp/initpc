#!/bin/bash
write_header "Configure Package Sources"

info "Setup pnpm"
pnpm setup

info "Setup NPM Azure Artifacts"
powershell.exe -c "Start-Process https://dev.azure.com/Tcetra/_usersSettings/tokens"

read -r -p "Enter your Personal Access Token (PAT) or press enter to skip: " PAT

if [[ -z "$PAT" ]]; then
    echo -e "\033[33mWarning: No Personal Access Token provided. Skipping...\033[0m"
else
    ENCODED_PAT=$(echo -n "$PAT" | base64)

    NPMRC_CONTENT="; begin auth token
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/registry/:username=Tcetra
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/registry/:_password=$ENCODED_PAT
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/registry/:email=npm requires email to be set but doesn't use the value
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/:username=Tcetra
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/:_password=$ENCODED_PAT
//pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/npm/:email=npm requires email to be set but doesn't use the value
; end auth token"

    echo "$NPMRC_CONTENT" >~/.npmrc
fi

info "Setup Nuget Azure Artifacts"

wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash
mkdir azureArtifactLogin
echo '<?xml version="1.0" encoding="utf-8"?><configuration><packageSources><clear /><add key="Tcetra-Packages" value="https://pkgs.dev.azure.com/Tcetra/_packaging/tcetra-pkgs/nuget/v3/index.json" /></packageSources></configuration>' >azureArtifactLogin/NuGet.Config
dotnet new web -o azureArtifactLogin
dotnet restore azureArtifactLogin --interactive
rm -rf azureArtifactLogin
