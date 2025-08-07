#!/bin/bash
write_header "Move files to XDG directories"
export HISTFILE="${XDG_CACHE_HOME}/bash/history"

if [ -d ~/.npm ]; then
    mkdir -p ~/.cache
    mv ~/.npm ~/.cache/npm
fi

mkdir -p ~/.config/npm
if [ -f ~/.npmrc ]; then
    mv ~/.npmrc ~/.config/npm/npmrc
fi

mkdir -p ~/.config/yarn
if [ -f ~/.yarnrc ]; then
    mv ~/.yarnrc ~/.config/yarn/config
fi

mkdir -p ~/.local/share
if [ -d ~/go ]; then
    sudo mv ~/go ~/.local/share/go
fi

mkdir -p ~/.cache
if [ -f ~/.wget-hsts ]; then
    mv ~/.wget-hsts ~/.cache/wget-hsts
fi
