# Dotfiles Configuration Overview

A comprehensive NixOS configuration focused on Hyprland desktop environment with development tools, media applications, and productivity software.

## Project Structure

```
dotfiles/
├── flake.nix                           # Main flake configuration with inputs and outputs 🌊 nixpkgs, home-manager, hyprland, zen-browser
├── config.nix                          # Configuration options schema definition
├── user-config.nix                     # User-specific configuration values → config.nix
│
├── hosts/                              # NixOS system configurations
│   └── T16/                            # ThinkPad T16 host configuration
│       ├── default.nix                 # Main system configuration 🌊 hyprland 📦 systemd-boot, networkmanager, pipewire, sddm
│       └── hardware-configuration.nix  # Hardware-specific settings (auto-generated)
│
└── home/                               # Home Manager user configurations
    ├── default.nix                     # Main home configuration → config.nix, user-config.nix, programs, hyprland 🌊 zen-browser
    │
    ├── programs/                       # Application configurations
    │   ├── default.nix                 # Program aggregator
    │   ├── btop.nix                    # System resource monitor 📦 btop
    │   ├── fish.nix                    # Fish shell configuration 📦 fish
    │   ├── fonts.nix                   # Font configuration 📦 nerd-fonts
    │   ├── ghostty.nix                 # GPU-accelerated terminal emulator 📦 ghostty
    │   ├── git.nix                     # Git configuration and aliases 📦 git
    │   ├── neovim/                     # Neovim editor configuration
    │   │   ├── default.nix             # Neovim setup 📦 neovim
    │   │   └── lazyvim/                # LazyVim configuration
    │   │       ├── init.lua            # LazyVim initialization
    │   │       ├── stylua.toml         # Lua code formatter config → stylua
    │   │       └── lua/                # Lua configuration modules
    │   │           ├── config/         # Core configuration
    │   │           │   ├── autocmds.lua    # Auto commands
    │   │           │   ├── keymaps.lua     # Key mappings
    │   │           │   ├── lazy.lua        # Lazy plugin manager setup
    │   │           │   └── options.lua     # Neovim options
    │   │           └── plugins/        # Plugin configurations
    │   │               ├── dap.lua         # Debug Adapter Protocol
    │   │               ├── dashboard.lua   # Dashboard plugin
    │   │               ├── helm-ls.lua     # Helm language server
    │   │               ├── lsp.lua         # Language Server Protocol
    │   │               ├── mason.lua       # Package manager for LSP servers
    │   │               ├── neo-tree.lua    # File explorer
    │   │               ├── none-ls.lua     # Null-ls replacement for formatting/linting
    │   │               ├── theme.lua       # Color theme configuration
    │   │               ├── tmux-navigator.lua # Tmux navigation
    │   │               └── treesitter.lua  # Syntax highlighting
    │   ├── obs-studio.nix              # OBS Studio configuration 📦 obs-studio
    │   ├── obsidian.nix                # Obsidian note-taking app 📦 obsidian
    │   ├── starship.nix                # Shell prompt configuration 📦 starship
    │   ├── xdg.nix                     # XDG directories and portals 📦 xdg-desktop-portal-hyprland
    │   ├── yazi.nix                    # Terminal file manager 📦 yazi
    │   └── zoxide.nix                  # Smart directory navigation 📦 zoxide
    │
    └── hyprland/                       # Hyprland window manager configuration
        ├── default.nix                 # Hyprland ecosystem packages 📦 hypridle, hyprlock, hyprshot, waybar, wofi
        ├── autostart.nix               # Autostart applications → hyprland.nix
        ├── bindings.nix                # Key bindings → hyprland.nix
        ├── configuration.nix           # Main Hyprland configuration → hyprland.nix
        ├── envs.nix                    # Environment variables → hyprland.nix
        ├── gestures.nix                # Touchpad gestures → hyprland.nix
        ├── hypridle.nix                # Idle management daemon 📦 hypridle
        ├── hyprland.nix                # Main Hyprland window manager config 🌊 hyprland
        ├── hyprlock.nix                # Screen lock configuration 📦 hyprlock
        ├── hyprpaper.nix               # Wallpaper daemon 📦 hyprpaper
        ├── input.nix                   # Input device configuration → hyprland.nix
        ├── looknfeel.nix               # Look and feel settings → hyprland.nix
        ├── mako.nix                    # Notification daemon 📦 mako
        ├── wallpapers/                 # Wallpaper images
        │   ├── everforest.jpg          # Everforest theme wallpaper
        │   ├── gruv-focus.png          # Gruvbox focused wallpaper
        │   ├── gruv.jpg                # Gruvbox wallpaper
        │   ├── gruvbox_minimal_space.png # Minimal Gruvbox space theme
        │   ├── gruvbox_minimal_space2.png # Alternative minimal space theme
        │   ├── macos.jpg               # macOS-style wallpaper
        │   └── starry-sky.png          # Starry sky wallpaper
        ├── waybar.nix                  # Status bar configuration 📦 waybar
        ├── windows.nix                 # Window rules and behavior → hyprland.nix
        └── wofi.nix                    # Application launcher 📦 wofi
```

## External Dependencies

This configuration depends on the following external flakes and packages:

### Core Infrastructure
- **`nixpkgs`** - Main Nix package repository (unstable branch)
- **`home-manager`** - User environment management

### Desktop Environment
- **`hyprland`** - Dynamic tiling Wayland compositor
- **`zen-browser`** - Privacy-focused web browser

### System Packages
- **Development Tools**: nodejs, rustc, go, lua, python312, gcc15, cmake, ninja
- **Language Servers**: lua-language-server, nixd, pyright, gopls, terraform-ls, yaml-language-server
- **CLI Utilities**: tree, eza, bat, fd, ripgrep, fzf, git, lazygit, zoxide
- **Media Tools**: vlc, ffmpeg, obs-studio, gimp
- **Productivity**: telegram-desktop, bitwarden, obsidian, qalculate-gtk
- **Hyprland Ecosystem**: hypridle, hyprlock, hyprshot, waybar, wofi, mako

## Key Features

### Desktop Environment
- **Hyprland-based**: Modern Wayland compositor with dynamic tiling
- **Complete Ecosystem**: Integrated idle management, screen lock, wallpapers, and status bar
- **Wayland Native**: Full Wayland support with XWayland fallback
- **Customizable**: Extensive theming and configuration options

### Development Setup
- **Neovim with LazyVim**: Comprehensive IDE setup with LSP, DAP, and plugins
- **Multi-language Support**: C/C++, Python, Go, Rust, Lua, JavaScript, Nix
- **Terminal Tools**: Fish shell, Starship prompt, Ghostty terminal
- **Version Control**: Git with LazyGit TUI integration

### Media & Productivity
- **Content Creation**: OBS Studio for streaming/recording, GIMP for image editing
- **Note Taking**: Obsidian with custom configuration
- **File Management**: Yazi terminal file manager with preview support
- **System Monitoring**: Btop for resource monitoring

### System Integration
- **Authentication**: Fingerprint support with fprintd
- **Audio**: PipeWire with ALSA and PulseAudio compatibility
- **Bluetooth**: Full Bluetooth stack with Blueman
- **Display**: SDDM display manager with Wayland support
- **Networking**: NetworkManager with GUI tools

## Configuration Philosophy

This dotfiles setup follows a **modular and declarative** approach:

1. **Separation of Concerns**: System configuration (NixOS) separate from user configuration (Home Manager)
2. **User Customization**: Centralized user settings in `user-config.nix` with schema validation
3. **Development Focus**: Comprehensive development environment with modern tooling
4. **Wayland First**: Native Wayland support throughout the stack
5. **Reproducible**: Fully declarative configuration with pinned dependencies

The configuration is optimized for **development workflows** while providing a **modern desktop experience** with the Hyprland compositor.

## Migration Guide: Adding Niri Support

### Overview
To test Niri compositor alongside Hyprland, we need to restructure the configuration to support multiple window managers while sharing common components.

### Proposed Structure Changes

```
home/
├── programs/                       # Application configurations (unchanged)
└── window-manager/                 # NEW: Centralized window manager configuration
    ├── shared/                     # Common components for all window managers
    │   ├── default.nix             # Shared packages and configuration
    │   ├── wallpapers/             # Shared wallpaper collection
    │   │   ├── everforest.jpg      # Everforest theme wallpaper
    │   │   ├── gruv-focus.png      # Gruvbox focused wallpaper
    │   │   ├── gruv.jpg            # Gruvbox wallpaper
    │   │   ├── gruvbox_minimal_space.png # Minimal Gruvbox space theme
    │   │   ├── gruvbox_minimal_space2.png # Alternative minimal space theme
    │   │   ├── macos.jpg           # macOS-style wallpaper
    │   │   └── starry-sky.png      # Starry sky wallpaper
    │   ├── waybar.nix              # Status bar (compositor-agnostic) 📦 waybar
    │   ├── mako.nix                # Notifications (works with both) 📦 mako
    │   ├── hypridle.nix            # Idle management (universal) 📦 hypridle
    │   ├── hyprlock.nix            # Screen lock (works with both) 📦 hyprlock
    │   └── wofi.nix                # Application launcher (works with both) 📦 wofi
    │
    ├── hyprland/                   # Hyprland-specific configuration
    │   ├── default.nix             # Hyprland setup → shared 📦 hyprshot, hyprpaper
    │   ├── autostart.nix           # Autostart applications → hyprland.nix
    │   ├── bindings.nix            # Key bindings → hyprland.nix
    │   ├── configuration.nix       # Main Hyprland configuration → hyprland.nix
    │   ├── envs.nix                # Environment variables → hyprland.nix
    │   ├── gestures.nix            # Touchpad gestures → hyprland.nix
    │   ├── hyprland.nix            # Main Hyprland window manager config 🌊 hyprland
    │   ├── hyprpaper.nix           # Wallpaper daemon (Hyprland-specific) 📦 hyprpaper
    │   ├── input.nix               # Input device configuration → hyprland.nix
    │   ├── looknfeel.nix           # Look and feel settings → hyprland.nix
    │   └── windows.nix             # Window rules and behavior → hyprland.nix
    │
    └── niri/                       # NEW: Niri compositor configuration
        ├── default.nix             # Niri setup → shared 🌊 niri 📦 seatd, jaq
        ├── niri.nix                # Main Niri configuration 🌊 niri
        ├── binds.nix               # Niri key bindings → niri.nix
        ├── rules.nix               # Window rules and behaviors → niri.nix
        └── settings.nix            # Compositor settings and configuration → niri.nix
```

### Benefits of This Structure

1. **Clear Separation**: Window manager configs are isolated from general programs
2. **Shared Resources**: Common components are centralized and reusable
3. **Scalability**: Easy to add more window managers (sway, river, etc.)
4. **Modularity**: Each compositor can import shared components as needed
5. **Organization**: Logical grouping makes the configuration easier to navigate

### XDG Portal Integration

#### How XDG Portals Work
XDG Desktop Portals provide a standardized way for applications to interact with the desktop environment for:
- **File Dialogs**: Opening/saving files from sandboxed applications
- **Screen Sharing**: Applications requesting screen capture permissions
- **Notifications**: System notification integration
- **Camera/Microphone**: Hardware access for applications
- **Theming**: GTK theme integration for applications

#### Current XDG Setup (Hyprland)
```nix
# In programs/xdg.nix
xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-hyprland  # Hyprland-specific portal
    pkgs.xdg-desktop-portal-gtk       # GTK applications support
  ];
  config.common.default = "*";
};
```

#### Required Changes for Niri Support
1. **Add Niri Portal**: Install `xdg-desktop-portal-gnome` or `xdg-desktop-portal-wlr` for Niri
2. **Conditional Configuration**: Switch portals based on active compositor
3. **Shared Portal Components**: Keep GTK portal for both environments

```nix
# Proposed xdg.nix structure
xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-hyprland  # For Hyprland
    pkgs.xdg-desktop-portal-gnome     # For Niri (or wlr)
    pkgs.xdg-desktop-portal-gtk       # Common for both
  ];
  config = {
    hyprland.default = ["hyprland" "gtk"];
    niri.default = ["gnome" "gtk"];  # or ["wlr" "gtk"]
  };
};
```

## Package Analysis: Kaku vs Dotfiles

### Common Packages (Present in Both)
#### Development Tools
- **Languages**: `nodejs`, `rustc`, `go`, `lua`, `python3`
- **Build Tools**: `cmake`, `gcc`, `gnumake`
- **Version Control**: `git`, `lazygit`
- **Language Servers**: `lua-language-server`, `nixd`, `pyright`, `gopls`

#### CLI Utilities
- **File Operations**: `tree`, `bat`, `fd`, `ripgrep`, `fzf`
- **System Tools**: `btop`/`bottom`, `zoxide`
- **Text Processing**: `jq`

#### Media & Productivity
- **Media**: `vlc`, `ffmpeg`, `obs-studio`
- **Browsers**: `chromium` (ungoogled in kaku, regular in dotfiles)
- **Communication**: `telegram-desktop`, `discord`
- **Security**: `bitwarden` -> change it to `1password`

#### Wayland Ecosystem
- **Core**: `wl-clipboard`, `grim`, `slurp`
- **Authentication**: `polkit_gnome`

### Kaku-Specific Packages
#### Desktop Environment (Niri-focused)
- **Compositor**: `niri` (main compositor)
- **Launchers**: `anyrun`, `quickshell`
- **Theming**: `stylix` (system-wide theming)
- **Additional**: `bibata-cursors`, `whitesur-icon-theme`

#### Browsers (Privacy-focused)
- **Primary**: `ungoogled-chromium` (vs regular chromium)
- **Additional**: `firefox-devedition`, `qutebrowser`, `epiphany`, `microsoft-edge`
- **Extensions**: `ublock-origin` (built-in)

#### Development (Extended)
- **Editors**: `helix`, `zed` (vs neovim focus in dotfiles)
- **Terminal**: `foot` (vs ghostty in dotfiles)
- **Shell**: `nushell` (vs fish in dotfiles)

#### System Tools
- **Hardware**: `brightnessctl`, `power-profiles-daemon`
- **Audio**: `playerctl`, `gammastep`
- **File Sync**: `syncthing`
- **Clipboard**: `cliphist`

### Dotfiles-Specific Packages
#### Development (Specialized)
- **Editor**: `neovim` with LazyVim (comprehensive IDE setup)
- **Terminal**: `ghostty` (GPU-accelerated)
- **Shell**: `fish` (user-friendly)
- **Additional**: `code-cursor`, `opencode`

#### Hyprland Ecosystem
- **Core**: `hyprland`, `hypridle`, `hyprlock`, `hyprshot`, `hyprpaper`
- **UI**: `waybar`, `wofi`, `mako`
- **Tools**: `hyprpicker`, `hyprshade`, `hyprsunset`

#### System Integration
- **Display**: `sddm` (display manager)
- **Hardware**: `fprintd` (fingerprint authentication)
- **Development**: More extensive language server collection
- **Utilities**: `wf-recorder`, `swappy`, `clipse`

#### Productivity & Media
- **Notes**: `obsidian` (vs no note-taking in kaku)
- **Graphics**: `gimp`
- **System**: `gnome-boxes` (virtualization)
- **Network**: `qbittorrent`

### Migration Recommendations

#### Phase 1: Shared Components
1. Move common Wayland tools to shared directory
2. Create conditional XDG portal configuration
3. Set up shared wallpapers and themes

#### Phase 2: Niri Integration
1. Add Niri compositor configuration
2. Port key bindings from kaku configuration
3. Configure window rules and settings

#### Phase 3: Testing & Optimization
1. Test switching between Hyprland and Niri
2. Verify XDG portal functionality in both environments
3. Optimize shared component loading

#### Phase 4: Package Consolidation
1. Identify packages to add from kaku (if desired)
2. Consider replacing some tools (e.g., ghostty vs foot)
3. Evaluate browser setup (privacy-focused vs development-focused)
