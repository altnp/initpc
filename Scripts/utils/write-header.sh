#!/bin/bash
write_header() {
    if [ -z "$1" ]; then
        echo "The prompt string must be provided."
        return 1
    fi

    local prompt="$1"
    echo -e "\n\e[32m${prompt}\n-------------------\e[0m"
}
