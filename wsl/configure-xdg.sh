#!/bin/bash
echo '
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
' | sudo tee -a /etc/profile >/dev/null

sudo mkdir -p /etc/zsh
sudo touch /etc/zsh/zshenv
echo '
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
' | sudo tee -a /etc/zsh/zshenv >/dev/null

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
