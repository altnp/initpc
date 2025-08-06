#!/bin/bash
info() {
    if [ -z "$1" ]; then
        echo "The prompt string must be provided."
        return 1
    fi

    local prompt="$1"
    echo -e "\n\e[36m${prompt}\e[0m"
}
