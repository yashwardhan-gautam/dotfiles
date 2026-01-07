# unalome's NixOS Dotfiles

A modern, opinionated NixOS configuration featuring **Niri** compositor with **DankMaterialShell** desktop environment.

## Table of Contents
- [Overview](#overview)
- [Quick Start](#quick-start)
- [Applications](#applications)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [Configuration Structure](#configuration-structure)
- [Resources](#resources)

## Overview

This dotfiles repository provides a complete NixOS desktop environment featuring:
- **Niri** - Scrollable tiling Wayland compositor
- **DankMaterialShell** - Modern desktop shell (launcher, notifications, clipboard, screenshots, etc.)
- **Catppuccin Frappe** theme
- **Ghostty** - GPU-accelerated terminal emulator
- **Zen Browser** - Privacy-focused web browser
- **Neovim** - Configured with LazyVim
- **Audio/Video** - PipeWire with multimedia controls

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
- **Browser**: Zen Browser (default), Brave & Chromium (available)
- **File Manager**: Yazi (terminal), COSMIC Files (GUI)
- **Editor**: Neovim with LazyVim configuration
- **Launcher**: DankMaterialShell Spotlight
- **Audio**: PipeWire
- **Clipboard**: DankMaterialShell clipboard manager
- **Screenshots**: DankMaterialShell screenshot tool
- **Password Manager**: Bitwarden

### Development Tools
- **Git** - Configured with user settings
- **Fish Shell** - User-friendly shell with Starship prompt
- **LazyGit** - Terminal UI for Git operations

## Keyboard Shortcuts

### Help
| Shortcut | Action |
|----------|--------|
| `Mod + Shift + /` | Show all shortcuts (hotkey overlay) |

### Application Launchers
| Shortcut | Application |
|----------|-------------|
| `Mod + Return` | Terminal (Ghostty) |
| `Mod + Space` | Application launcher (DMS Spotlight) |
| `Mod + E` | File manager (Yazi) |
| `Mod + B` | Browser (Zen) |

### DankMaterialShell Features
| Shortcut | Action |
|----------|--------|
| `Mod + Escape` | Lock screen |
| `Mod + V` | Clipboard history |
| `Mod + N` | Notifications panel |
| `Mod + Shift + N` | Notepad |
| `Mod + M` | Process/Task manager |
| `Mod + Alt + S` | DMS Settings |

### Window Management
| Shortcut | Action |
|----------|--------|
| `Mod + Q` | Close window |
| `Mod + F` | Maximize column |
| `Mod + Shift + F` | Fullscreen window |
| `Mod + D` | Cycle preset column widths (33%/50%/67%) |
| `Mod + Shift + Space` | Reset window height |

### Window Navigation (Vim-style)
| Shortcut | Action |
|----------|--------|
| `Mod + H` | Focus column left |
| `Mod + J` | Focus window/workspace down |
| `Mod + K` | Focus window/workspace up |
| `Mod + L` | Focus column right |

### Move Windows
| Shortcut | Action |
|----------|--------|
| `Mod + Shift + H` | Move column left |
| `Mod + Shift + J` | Move window down/to workspace below |
| `Mod + Shift + K` | Move window up/to workspace above |
| `Mod + Shift + L` | Move column right |

### Resize Windows
| Shortcut | Action |
|----------|--------|
| `Mod + -` | Decrease column width 10% |
| `Mod + =` | Increase column width 10% |
| `Mod + Shift + -` | Decrease window height 10% |
| `Mod + Shift + =` | Increase window height 10% |

### Workspace Management
| Shortcut | Action |
|----------|--------|
| `Mod + 1-9` | Switch to workspace 1-9 |
| `Mod + Shift + 1-9` | Move window to workspace 1-9 |
| `Mod + Tab` | Next workspace |
| `Mod + Shift + Tab` | Previous workspace |

### Session Management
| Shortcut | Action |
|----------|--------|
| `Mod + Shift + E` | Quit Niri |
| `Mod + Shift + R` | Reload Niri config |

### Screenshots (via DMS)
| Shortcut | Action |
|----------|--------|
| `Print` | Area selection → clipboard |
| `Shift + Print` | Area selection → file + clipboard |
| `Ctrl + Print` | Full screen → clipboard |
| `Ctrl + Shift + Print` | Full screen → file + clipboard |
| `Alt + Print` | Window → clipboard |
| `Alt + Shift + Print` | Window → file + clipboard |

### Media Controls (Hardware Keys)
| Key | Action |
|-----|--------|
| `Volume Up/Down` | Adjust volume (±3%) |
| `Volume Mute` | Toggle mute |
| `Mic Mute` | Toggle microphone mute |
| `Brightness Up/Down` | Adjust brightness (±5%) |

### Ghostty Terminal Shortcuts

#### Window Management
| Shortcut | Action |
|----------|--------|
| `Ctrl + Shift + Q` | Quit terminal |
| `Alt + F4` | Close window |
| `Ctrl + Shift + N` | New window |

#### Tab Management
| Shortcut | Action |
|----------|--------|
| `Ctrl + Shift + T` | New tab |
| `Ctrl + W` | Close tab |
| `Ctrl + Tab` | Next tab |
| `Ctrl + Shift + Tab` | Previous tab |
| `Alt + 1-9` | Go to tab 1-9 |

#### Split Management
| Shortcut | Action |
|----------|--------|
| `Alt + E` | Split horizontally |
| `Alt + V` | Split vertically |
| `Alt + W` | Close split |
| `Alt + H/J/K/L` | Navigate splits |
| `Ctrl + Shift + ↑/↓/←/→` | Resize splits |

#### Text & Selection
| Shortcut | Action |
|----------|--------|
| `Ctrl + Shift + C` | Copy to clipboard |
| `Ctrl + Shift + V` | Paste from clipboard |
| `Ctrl + Shift + A` | Select all |
| `Ctrl + +/-` | Increase/decrease font size |
| `Ctrl + 0` | Reset font size |

## Configuration Structure

```
dotfiles/
├── flake.nix                 # Main flake configuration
├── config.nix                # User configuration options
├── hosts/T16/                # Host-specific configuration
│   ├── default.nix           # System configuration
│   └── hardware-configuration.nix
└── home/                     # Home Manager configuration
    ├── default.nix           # Main home config + DMS setup
    └── programs/             # Application configurations
        ├── ghostty.nix       # Terminal configuration
        ├── neovim/           # Neovim setup with LazyVim
        ├── fish.nix          # Shell configuration
        ├── git.nix           # Git settings
        ├── gtk.nix           # GTK/Qt theming (Catppuccin)
        ├── niri/             # Niri compositor config
        │   ├── default.nix   # Niri home-manager setup
        │   └── config.kdl    # Niri keybindings & settings
        └── ...
```

## Resources

- [Niri](https://github.com/YaLTeR/niri) - Scrollable tiling Wayland compositor
- [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell) - Desktop shell for Niri
- [Catppuccin](https://github.com/catppuccin/catppuccin) - Soothing pastel theme

## License

This configuration is provided as-is for educational and personal use. 
