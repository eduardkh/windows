# Terminals for windows

> alacritty (minimal Terminal Emulator)

```powershell
# install with Chocolatey (and fonts)
choco install alacritty -y
choco install nerd-fonts-FiraCode -y

# run with debug
alacritty -v

# config file
alacritty --config-file "C:\paoth\to\alacritty.yml"
# default config file
%APPDATA%\alacritty
# in CMD the location is here
dir %APPDATA%\alacritty
# in PS the location is here
dir $env:APPDATA\alacritty
```

> starship (Themes and stuff)

```powershell
# install with Chocolatey (and fonts)
choco install starship -y

# run in powershell to activate starship
Invoke-Expression (&starship init powershell)
# to make it permanent place it in $PROFILE
```
