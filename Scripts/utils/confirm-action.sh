#!/bin/bash

confirm_action() {
    while true; do
        read -p "${1:-Are you sure you want to proceed?} [y/n] " confirmation

        case "$confirmation" in
            y|Y) return 0;;
            n|N) return 1;;
            *) echo -e "\e[31mPlease enter 'y' for Yes or 'n' for No.\e[0m";; # Red color output
        esac
    done
}
