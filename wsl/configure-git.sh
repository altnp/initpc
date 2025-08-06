#!/bin/bash
write_header "Setup GitHub CLI"

if confirm_action "Would you like to signin to GitHub CLI"; then
    gh auth login --web

    if confirm_action "Would you like to install GitHub Copilot CLI"; then
        gh extension install github/gh-copilot
    fi
fi
