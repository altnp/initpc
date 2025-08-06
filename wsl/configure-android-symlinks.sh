#!/bin/bash
WIN_ANDROID_SDK="/mnt/c/Android/android-sdk"
LINUX_ANDROID_SDK="/opt/android-sdk"

if [ -d "$WIN_ANDROID_SDK" ]; then
    if [ -f "$WIN_ANDROID_SDK/platform-tools/adb.exe" ]; then
        mkdir -p "$LINUX_ANDROID_SDK/platform-tools"
        if [ -f "$LINUX_ANDROID_SDK/platform-tools/adb" ] && [ ! -L "$LINUX_ANDROID_SDK/platform-tools/adb" ]; then
            mv "$LINUX_ANDROID_SDK/platform-tools/adb" "$LINUX_ANDROID_SDK/platform-tools/adb.wsl.bak" || true
        fi
        ln -sf "$WIN_ANDROID_SDK/platform-tools/adb.exe" "$LINUX_ANDROID_SDK/platform-tools/adb"
        info "Symlinked adb to Windows SDK"
    fi

    if [ -f "$WIN_ANDROID_SDK/emulator/emulator.exe" ]; then
        mkdir -p "$LINUX_ANDROID_SDK/emulator"
        if [ -f "$LINUX_ANDROID_SDK/emulator/emulator" ] && [ ! -L "$LINUX_ANDROID_SDK/emulator/emulator" ]; then
            mv "$LINUX_ANDROID_SDK/emulator/emulator" "$LINUX_ANDROID_SDK/emulator/emulator.wsl.bak" || true
        fi
        ln -sf "$WIN_ANDROID_SDK/emulator/emulator.exe" "$LINUX_ANDROID_SDK/emulator/emulator"
        info "Symlinked emulator to Windows SDK"
    fi
fi
