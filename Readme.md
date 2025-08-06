# Prerequisite

The following must be ran from an administrator powershell (not powershell core) instance

- Install Chocolatey

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));

start-process powershell.exe -verb RunAs; exit;
```

- Install Git

```
winget install -e -id Git.Git

start-process powershell.exe -verb RunAs; exit;
```

- Set Execution Policy for User

```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -f
```

- Clone This Repo

```
git config --global core.autocrlf input
git clone https://github.com/altnp/initpc.git "$env:USERPROFILE\initpc\"
```

- Comment out any programs you want to skip installing in `programs.winget`
- Execute `. ~\initpc\init.ps1` from a administrator powershell instance

# Not yet scripted:

## Docker Desktop

- Enable K8s
- Update your docker engine.json to be:

```
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false,
  "log-driver": "json-file",
  "log-opts": {
    "compress": "true",
    "max-file": "3",
    "max-size": "100m"
  }
}

```

## Windhawk

- Enable Taskbar height and icon size
  - 40/20/40/43/32

## Power Toys

- Power Toys Run & Fancy Zone Setup
