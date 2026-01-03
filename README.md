# unalome's NixOS Dotfiles

A modern, opinionated NixOS configuration now centered around the **niri** Wayland compositor with **DankMaterialShell (DMS)** providing the desktop shell, plus optional COSMIC and Hyprland profiles for experimentation.

## Screenshots

![Latest Desktop Screenshot](media/2025-08-05-021925_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-021633_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-021352_hyprshot.png)
![Desktop Screenshot](media/2025-08-05-014356_hyprshot.png)

## Table of Contents
- [Overview](#overview)
- [Quick Start](#quick-start)
- [Applications](#applications)
- [Niri & DMS Shortcuts](#niri--dms-shortcuts)
- [Configuration Structure](#configuration-structure)
- [Resources](#resources)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository provides a reproducible NixOS desktop with:
- **niri + DankMaterialShell** – tiled Wayland compositor with a cohesive Material shell (overview, dock, spotlight, widgets).
- **Kitty + Neovim** – primary terminal and editor (LazyVim based) for all development work.
- **Zen Browser** – default daily driver browser with privacy-friendly defaults.
- **PipeWire audio** – multimedia routing with playerctl/wpctl bindings and brightness controls.
- **Wayland tooling** – grim, slurp, wl-clipboard, hyprpicker, swaylock, etc., wired through the compositor.
- **Optional profiles** – COSMIC and Hyprland configurations remain available for quick experiments.

## Quick Start

### Flake Targets
- `.#T16` – COSMIC desktop (default system profile)
- `.#T16-hyprland` – legacy Hyprland setup
- `.#T16-niri` – current niri + DMS desktop
- `.#unalome` – standalone Home Manager profile

### Deploy
```bash
# Clone the repo
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Switch the host to the niri profile
sudo nixos-rebuild switch --flake .#T16-niri

# Optionally apply Home Manager only
home-manager switch --flake .#unalome
```

## Applications

### Core Shell
- **Launcher**: DMS Spotlight (`Mod+Space`) with Wofi (`Mod+Shift+Space`) for fallback menus.
- **Terminal**: Kitty (GPU-accelerated, used for every workflow).
- **Editor**: Neovim (LazyVim configuration) opened via Kitty bindings.
- **Browser**: Zen Browser (primary) plus Chromium/Brave available if needed.
- **File Manager**: Dolphin for GUI tasks; Yazi inside Kitty for terminal workflows.
- **Communication**: Telegram and Vesktop launched straight from compositor binds.
- **Lock Screen**: swaylock (triggered by `Super+Alt+L`).
- **Recording & Streaming**: OBS Flatpak launched on demand (`Mod+Shift+O`).

### Tooling & Services
- PipeWire + WirePlumber audio stack with fine-grained media/volume keys.
- wl-clipboard + cliphist for clipboard history (managed by DMS widgets).
- grim/slurp for screenshots, hyprpicker for color sampling.
- Brightness and media controls wired to hardware XF86 keys.

## Niri & DMS Shortcuts

### Launchers & Session
| Shortcut | Action |
|----------|--------|
| `Super + Space` | Open DMS Spotlight launcher |
| `Super + Shift + Space` | Launch Wofi (`drun`, alphabetical) |
| `Super + Ctrl + Space` | Reload Waybar (pkill or start) |
| `Super + Return` / `Super + T` | Open Kitty terminal |
| `Super + Shift + Z` | Open Neovim inside Kitty |
| `Super + F` | Launch Dolphin |
| `Super + B` | Launch Zen Browser |
| `Super + G` | Launch Telegram |
| `Super + D` | Launch Vesktop |
| `Super + Ctrl + Return` | Floating Kitty scratch terminal |
| `Super + Shift + O` | Launch OBS (Flatpak) |
| `Super + Alt + L` | Lock screen via swaylock |

### Window & Workspace Navigation
| Shortcut | Action |
|----------|--------|
| `Super + H/J/K/L` or arrows | Move focus between columns/windows |
| `Super + Ctrl + H/J/K/L` | Move active column/window |
| `Super + Home/End` | Jump to first/last column |
| `Super + numbers 1-9` | Switch workspaces |
| `Super + Ctrl + numbers` | Move column to workspace |
| `Super + mouse wheel` | Cycle workspaces (scroll up/down) |
| `Super + S` | Toggle special workspace `utility` |
| `Super + Shift + S` | Send focused column to special workspace |
| `Super + Shift + Ctrl + arrows` | Move column across monitors |

### Layout & Floating
| Shortcut | Action |
|----------|--------|
| `Super + V` | Toggle column tabbed mode |
| `Super + W` | Toggle window floating |
| `Super + Shift + W` | Swap focus between floating and tiled layers |
| `Super + R` | Cycle preset column widths |
| `Super + Shift + R` | Cycle preset window heights |
| `Super + Ctrl + R` | Reset window height |
| `Super + Minus/Equal` | Shrink/Grow column width |
| `Super + Shift + Minus/Equal` | Shrink/Grow window height |
| `Super + Ctrl + F` | Maximize column |
| `Super + Shift + F` | Fullscreen window |
| `Super + C` / `Super + Alt + C` | Center current / all visible columns |

### Media, Screenshots & Utilities
| Shortcut | Action |
|----------|--------|
| `XF86Audio*` keys | Volume/mute/mic controls via wpctl |
| `XF86MonBrightness*` | Adjust backlight via brightnessctl |
| `Super + Print` | Color picker (hyprpicker) |
| `Super + Shift + S` | Niri area screenshot (stored in `~/Pictures/Screenshots`) |
| `Ctrl + Print` / `Alt + Print` | Screenshot screen / active window |
| `Super + Escape` | Toggle keyboard shortcut inhibitor |
| `Super + Shift + E` | Quit niri |
| `Ctrl + Alt + Delete` | Quick exit/quit |
| `Super + Shift + P` | Turn off displays |

## Configuration Structure

```
dotfiles/
├── flake.nix                 # Main flake definition (niri, DMS, COSMIC, Hyprland)
├── hosts/T16/
│   ├── default.nix           # Host configuration with selectable window managers
│   └── hardware-configuration.nix
└── home/
    ├── default.nix           # Home Manager entry point (selects hyprland or niri)
    ├── programs/             # Shared program modules (kitty, neovim, fish, etc.)
    ├── hyprland/             # Legacy Hyprland configuration tree
    │   ├── default.nix
    │   ├── bindings.nix
    │   └── ...
    └── niri/                 # Primary niri configuration tree
        ├── default.nix       # Wires the module
        ├── configuration.nix # Enables wayland.windowManager.niri
        └── config/config.kdl # Unified compositor config
```

## Resources

Inspirations and references:
- **[OrynOS](https://github.com/OrynVail/OrynOS)** – declarative Hyprland/NixOS ideas.
- **[Omarchy](https://github.com/basecamp/omarchy/tree/master)** – polished Wayland workflows.
- **[omarchy-nix](https://github.com/henrysipp/omarchy-nix)** – NixOS translation of Omarchy concepts.

## Contributing

Fork away! Issues and pull requests are welcome if you spot improvements.

## License

Provided as-is for educational and personal use.
