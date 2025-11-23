#!/bin/bash
write_header "Generating SSH Key for Machine"

echo -n "Input SSH Key Label: "
read -r label

ssh-keygen -t rsa -b 4096 -C "$label" -N '' -f ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
xclip -selection clipboard <~/.ssh/id_rsa.pub

if confirm_action $'\nWould you like to import the key into github?'; then
    powershell.exe -c "Start-Process https://github.com/settings/keys"
fi

info "Press Enter to continue..."
read -r
