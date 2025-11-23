mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

sudo pacman -Sy --noconfirm

pushd .
mkdir -p ~/tmp && cd ~/tmp || exit

info "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel go
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si
cd ..

info "Installing Core Utils..."
sudo pacman -S wget --noconfirm
sudo pacman -S --noconfirm unzip
sudo pacman -S --noconfirm xclip
sudo pacman -S --noconfirm jq
sudo pacman -S --noconfirm fzf
sudo pacman -S --noconfirm ripgrep
sudo pacman -S --noconfirm fd
sudo pacman -S --noconfirm eza
sudo pacman -S --noconfirm bat
sudo pacman -S --noconfirm delta
sudo pacman -S --noconfirm zoxide
sudo pacman -S --noconfirm tmux
sudo pacman -S --noconfirm zsh
sudo pacman -S --noconfirm chezmoi
sudo pacman -S --noconfirm bottom
sudo pacman -S --noconfirm openssh
sudo pacman -S --noconfirm bash-completion
sudo pacman -S --noconfirm man-db
sudo pacman -S --noconfirm tldr
sudo pacman -S --noconfirm fastfetch
sudo pacman -S --noconfirm inetutils
sudo pacman -S --noconfirm net-tools
sudo pacman -S --noconfirm lsof

sudo wget https://github.com/doron-cohen/antidot/releases/download/v0.6.3/antidot_0.6.3_Linux_x86_64 -O /usr/local/bin/antidot
sudo chmod +x /usr/local/bin/antidot

info "Installing NeoVim..."
sudo pacman -S --noconfirm neovim

info "Installing CLIs..."
sudo pacman -S --noconfirm redis
sudo pacman -S --noconfirm github-cli
sudo pacman -S --noconfirm azure-cli
sudo pacman -S --noconfirm aws-cli
sudo pacman -S --noconfirm terraform
yay -S --noconfirm aws-session-manager-plugin

info "Installing SDKs & Dev Tools..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --lts
nvm use --lts
npm install --global corepack@latest
corepack enable pnpm
corepack enable yarn
yes | pnpm
yes | yarn
npm install -g @angular/cli
npm install -g yo
npm install -g tsx
npm install -g nx
npm install -g vsce
npm install -g @bitwarden/cli

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x dotnet-install.sh
sudo ./dotnet-install.sh -Channel 2.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 3.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 5.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 6.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 7.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 8.0 -InstallDir /lib/dotnet
sudo ./dotnet-install.sh -Channel 9.0 -InstallDir /lib/dotnet
sudo ln -s /lib/dotnet/dotnet /usr/bin/dotnet
export DOTNET_ROOT="/lib/dotnet"
echo 'export DOTNET_ROOT="/lib/dotnet"' >>~/.bashrc

dotnet tool install Octopus.DotNet.Cli -g

sudo pacman -S --noconfirm rust

sudo pacman -S --noconfirm jdk21-openjdk
sudo pacman -S --noconfirm jdk17-openjdk
sudo pacman -S --noconfirm jdk11-openjdk
sudo pacman -S --noconfirm jdk8-openjdk
sudo pacman -S --noconfirm jdk-openjdk

# Set default Java to 17 using archlinux-java
if command -v archlinux-java >/dev/null 2>&1; then
    sudo archlinux-java set java-17-openjdk
    echo "Set default Java to java-17-openjdk"
fi

# Android Begin
yay -S --noconfirm android-sdk-cmdline-tools-latest
export ANDROID_HOME='/opt/android-sdk'
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
yes | sudo sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" "platforms;android-35" "build-tools;35.0.0"
sudo tee /etc/profile.d/android-sdk-platform-tools.sh >/dev/null <<'EOF'
export ANDROID_HOME='/opt/android-sdk'
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"
EOF

sudo groupadd android-sdk
sudo chgrp -R android-sdk /opt/android-sdk
sudo chmod -R g+w /opt/android-sdk
sudo usermod -aG android-sdk "$(whoami)"

cargo install adb-wireless
# Android End

sudo pacman -S --noconfirm python-pip python-pipx uv

pipx install sqlfluff

sudo pacman -S --noconfirm shellcheck
go install mvdan.cc/sh/v3/cmd/shfmt@latest

sudo pacman -S --noconfirm helm
go install sigs.k8s.io/kind@v0.29.0

curl -s https://ohmyposh.dev/install.sh | bash -s

info "Setup pnpm"
pnpm setup

popd || exit
rm -rf ~/tmp
