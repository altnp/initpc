#!/bin/bash
write_header "Configuring dotfiles..."

chezmoi init git@github.com:altnp/dotfiles.git
chezmoi apply

reposDir=$(chezmoi data | jq -r '.reposDir')
reposDir="${reposDir/#\~/$HOME}"

mkdir -p "$reposDir"
mkdir -p "$reposDir/pvt"
mkdir -p "$reposDir/oss"
mkdir -p "$reposDir/local"
mkdir -p "$reposDir/yipit"
