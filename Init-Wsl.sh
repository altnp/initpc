#!/bin/bash
echo $PWD

for script in ./scripts/utils/*.sh; do
    . "$script"
done

. ./wsl/configure-xdg.sh
. ./wsl/configure-locale.sh
. ./wsl/install-programs.sh
. ./wsl/configure-ssh-key.sh
. ./wsl/configure-git.sh
. ./wsl/configure-dotfiles.sh
. ./wsl/configure-zsh.sh
. ./wsl/configure-android-symlinks.sh
. ./wsl/configure-xdg-post.sh
