#!/bin/bash
write_header "Configuring Zsh..."
zshBin=$(which zsh)
if [ -n "$zshBin" ]; then
    echo "$zshBin" | sudo tee -a /etc/shells >/dev/null
    while ! chsh -s "$zshBin"; do
        echo "Authentication failed or chsh error. Please try again."
    done
fi
