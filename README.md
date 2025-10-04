# unalome's NixOS Dotfiles

A modern, opinionated NixOS configuration featuring Hyprland window manager with a complete desktop environment setup.

## Screenshots

![Latest Desktop Screenshot](media/2025-08-05-021925_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-021633_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-021352_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-014356_hyprshot.png)

## Table of Contents
- [Overview](#overview)
- [Quick Start](#quick-start)
- [Applications](#applications)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [Configuration Structure](#configuration-structure)
- [Customization](#customization)
- [Migration Notes](#migration-notes)
- [Resources](#resources)

## Overview

This dotfiles repository provides a complete NixOS desktop environment featuring:
- **Hyprland** - Modern tiling Wayland compositor
- **Gruvbox Light** theme with custom colors
- **Waybar** - Customizable status bar
- **Ghostty** - GPU-accelerated terminal emulator
- **Chromium** - Ungoogled Chromium browser
- **Neovim** - Configured with LazyVim
- **Audio/Video** - PipeWire with multimedia controls
- **Security** - Hyprlock screen locker with idle management

## Quick Start

### Prerequisites
- NixOS installed
- Flakes enabled in your Nix configuration

### Installation
```bash
# Clone the repository
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Build and switch to the configuration
sudo nixos-rebuild switch --flake .#T16

# Or for standalone home-manager
home-manager switch --flake .#unalome
```

## Applications

### Core Applications
- **Terminal**: Ghostty (GPU-accelerated)
- **Browser**: Chromium (ungoogled), Zen Browser
- **File Manager**: Yazi (terminal file manager)
- **Editors**: Neovim (LazyVim), Zed, Cursor
- **Launcher**: Wofi (application launcher)
- **Audio**: PipeWire with WirePlumber
- **Bluetooth**: Blueberry manager
- **Network**: NetworkManager with GUI applet
- **Password Manager**: Bitwarden (open-source password manager)

### Development Tools
- **Git** - Configured with user settings
- **Fish Shell** - User-friendly shell with Starship prompt
- **btop** - Modern system resource monitor
- **LazyGit** - Terminal UI for Git operations

## Keyboard Shortcuts

(Same as previous README)

## Configuration Structure

```
dotfiles/
├── flake.nix               # Main flake configuration
├── hosts/T16/              # Host-specific configuration
│   ├── default.nix         # System configuration
│   └── hardware-configuration.nix
├── home/                   # Home Manager configuration
│   ├── default.nix         # Main home configuration
│   ├── services/           # System and Wayland services
│   │   ├── system/         # User system services
│   │   │   ├── cliphist.nix # Clipboard manager
│   │   │   ├── power-monitor.nix # Power profile management
│   │   │   └── ...
│   │   └── wayland/        # Wayland-specific services
│   │       ├── default.nix  # Wayland packages and imports
│   │       └── ...
│   ├── programs/           # Application configurations
│   │   ├── ghostty.nix     # Terminal configuration
│   │   ├── neovim/         # Neovim setup with LazyVim
│   │   ├── fish.nix        # Shell configuration
│   │   ├── git.nix         # Git settings
│   │   └── ...
│   └── editors/            # Editor configurations
│       ├── zed/            # Zed editor setup
│       ├── cursor/         # Cursor editor config
│       └── neovim/         # LazyVim configuration
└── system/                 # System-level configurations
    ├── services/           # System-wide services
    │   ├── networking.nix  # Network configuration
    │   ├── pipewire.nix    # Audio system setup
    │   └── power.nix       # Power management
    └── hardware/           # Hardware-specific modules
        ├── bluetooth.nix   # Bluetooth configuration
        ├── fwupd.nix       # Firmware updates
        └── ...
```

## Migration Notes

### Changes from Previous Configuration

#### Architectural Improvements
- **Modular Service Configuration**: Separated services into more granular modules
- **Enhanced Power Management**: Switched to power-profiles-daemon with intelligent monitor
- **Improved Clipboard Management**: Upgraded to cliphist with image support
- **Streamlined Editor Workflow**: Integrated multiple editors (Zed, Cursor, Neovim)

#### Removed Components
- Gaming-related services and packages
- Redundant configurations
- Unnecessary system bloat

## Resources

(Same as previous README)

## Contributing

Feel free to fork this repository and adapt it to your needs. If you find improvements or fixes, pull requests are welcome!

## License

This configuration is provided as-is for educational and personal use. 