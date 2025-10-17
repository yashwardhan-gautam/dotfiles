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
    │   ├── wofi.nix                # Application launcher (works with both) 📦 wofi
    │   └── wlogout.nix             # Logout menu (Wayland-native) 📦 wlogout
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
        └── config.kdl              # Main Niri configuration in KDL format 🌊 niri
```

### Benefits of This Structure

1. **Clear Separation**: Window manager configs are isolated from general programs
2. **Shared Resources**: Common components are centralized and reusable
3. **Scalability**: Easy to add more window managers (sway, river, etc.)
4. **Modularity**: Each compositor can import shared components as needed
5. **Organization**: Logical grouping makes the configuration easier to navigate

### Niri Configuration Approach

The Niri configuration uses a **KDL (KubeConf Document Language)** format for cleaner and more readable configuration management. This approach is inspired by [JotaFab/s13los](https://github.com/JotaFab/s13los/blob/main/modules/home/niri/config.kdl) repository.

#### KDL Configuration Structure
```kdl
// config.kdl - Main Niri configuration
output "eDP-1" {
    scale 1.0
    position x=0 y=0
}

output "HDMI-A-1" {
    mode "1920x1080@60"
    scale 1.0
    position x=0 y=-1080
}

layout {
    gaps 12
    center-focused-column "never"
    preset-column-widths {
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
    }
}

binds {
    "Mod+Return" { spawn "ghostty"; }
    "Mod+Q" { close-window; }
    "Mod+F" { maximize-column; }
    // ... additional keybindings
}

window-rules {
    geometry-corner-radius 12.0
    clip-to-geometry true
    
    match app-id="firefox" {
        open-maximized true
    }
}
```

#### Advantages of KDL Format
1. **Readability**: More intuitive syntax compared to nested Nix expressions
2. **Maintainability**: Easier to modify and understand configuration options
3. **Native Support**: Direct support by Niri compositor without translation layers
4. **Validation**: Built-in syntax validation and error reporting
5. **Documentation**: Self-documenting structure with clear hierarchies

### Material Design 3 Integration

The configuration can be enhanced with **Material You** theming using [mitsugen](https://github.com/DimitrisMilonopoulos/mitsugen), which provides dynamic color generation based on wallpapers following Google's Material Design 3 specifications.

#### Material You Theming Workflow
```bash
# Install mitsugen
git clone https://github.com/DimitrisMilonopoulos/mitsugen.git
cd mitsugen && chmod +x install.sh && ./install.sh
poetry install

# Generate themes from wallpaper
poetry run python src/main.py --wallpaper ~/wallpapers/current.jpg --ui

# For light theme variant
poetry run python src/main.py --wallpaper ~/wallpapers/current.jpg -l
```

#### Supported Applications
- **System-wide**: GTK4/GTK3 applications with consistent Material Design colors
- **Desktop Environment**: GNOME Shell theming with dynamic color adaptation
- **Development**: VS Code with Material You custom CSS integration
- **Productivity**: Obsidian with Adwaita theme compatibility
- **Communication**: Discord via BetterDiscord Material theme
- **Media**: Spotify with Material You color schemes
- **File Management**: Papirus adaptive folder icons matching color palette

#### Benefits of Material Design 3
1. **Dynamic Colors**: Automatic color palette generation from wallpapers
2. **Accessibility**: Built-in contrast and readability standards
3. **Consistency**: Unified theming across all applications
4. **Personalization**: Wallpaper-driven color schemes for unique aesthetics
5. **Modern Design**: Latest Material Design principles and components

### Wayland Logout Menu Integration

The desktop environment can be enhanced with [wlogout](https://github.com/ArtsyMacaw/wlogout), a Wayland-native logout menu that provides elegant power management options with full customization support.

#### wlogout Configuration Structure
```json
// ~/.config/wlogout/layout - Custom button layout
{
    "label" : "shutdown",
    "action" : "systemctl poweroff",
    "text" : "Shutdown",
    "keybind" : "s"
},
{
    "label" : "reboot", 
    "action" : "systemctl reboot",
    "text" : "Reboot",
    "keybind" : "r"
},
{
    "label" : "logout",
    "action" : "hyprctl dispatch exit || niri msg action quit",
    "text" : "Logout", 
    "keybind" : "l"
}
```

#### Waybar Integration
```json
// waybar configuration module
"custom/power": {
    "format": "⏻",
    "tooltip": false,
    "on-click": "wlogout -p layer-shell",
    "class": "power-button"
}
```

#### Material Design 3 Styling
```css
/* ~/.config/wlogout/style.css - Material You theming */
window {
    background-color: rgba(30, 30, 46, 0.9);
    backdrop-filter: blur(20px);
}

button {
    background-color: @surface-container;
    color: @on-surface;
    border-radius: 12px;
    border: 2px solid @outline-variant;
    transition: all 200ms ease-in-out;
}

button:hover {
    background-color: @primary-container;
    color: @on-primary-container;
    border-color: @primary;
}
```

#### Power Management Features
1. **Session Control**: Logout from Hyprland/Niri sessions
2. **System Power**: Shutdown, reboot, suspend, hibernate options
3. **Screen Lock**: Integration with hyprlock for both compositors
4. **Keyboard Navigation**: Vim-like keybindings for quick access
5. **Visual Feedback**: Smooth animations and Material Design transitions
6. **Accessibility**: High contrast support and screen reader compatibility

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
1. Create `config.kdl` file using KDL format (inspired by [JotaFab/s13los](https://github.com/JotaFab/s13los))
2. Convert existing Nix-based settings to KDL syntax
3. Port key bindings and window rules to unified KDL configuration
4. Set up Niri package integration in `default.nix`

#### Phase 3: Testing & Optimization
1. Test switching between Hyprland and Niri
2. Verify XDG portal functionality in both environments
3. Optimize shared component loading

#### Phase 4: Material Design 3 Theming
1. Explore Material You theming with [mitsugen](https://github.com/DimitrisMilonopoulos/mitsugen)
2. Generate dynamic color schemes from wallpapers using Material Design 3 color system
3. Apply Material You themes to:
   - **GTK4/GTK3** applications for consistent system theming
   - **GNOME Shell** for desktop environment integration
   - **VS Code** with custom CSS for development environment
   - **Obsidian** with Adwaita theme compatibility
   - **Discord** via BetterDiscord Material theme
   - **Spotify** with Material You color adaptation
4. Configure adaptive folder icons with Papirus integration
5. Set up wallpaper-based dynamic theming workflow

#### Phase 5: Wayland Logout Menu Integration
1. Integrate [wlogout](https://github.com/ArtsyMacaw/wlogout) for elegant logout/power management
2. Configure wlogout with Material Design 3 theming to match system aesthetic
3. Add waybar integration with custom logout button and styling
4. Set up custom layout with power options:
   - **Logout** - End current session
   - **Shutdown** - Power off system
   - **Reboot** - Restart system
   - **Suspend** - Sleep mode
   - **Lock** - Screen lock (hyprlock/niri lock)
   - **Hibernate** - Deep sleep mode
5. Configure keyboard shortcuts and waybar click actions
6. Style with CSS to match Material You color scheme

#### Phase 6: Package Consolidation
1. Identify packages to add from kaku (if desired)
2. Consider replacing some tools (e.g., ghostty vs foot)
3. Evaluate browser setup (privacy-focused vs development-focused)

## References and Inspiration

### Niri Configuration
- **[JotaFab/s13los](https://github.com/JotaFab/s13los)** - Inspiration for KDL-based Niri configuration approach
- **[Niri Compositor](https://github.com/YaLTeR/niri)** - Official Niri scrollable-tiling Wayland compositor
- **[KDL Document Language](https://kdl.dev/)** - Configuration language specification

### Material Design & Theming
- **[mitsugen](https://github.com/DimitrisMilonopoulos/mitsugen)** - Material You theming for GNOME, GTK4/GTK3, and various applications
- **[Material Design 3](https://m3.material.io/)** - Google's latest design system with dynamic color
- **[Papirus Folders](https://github.com/PapirusDevelopmentTeam/papirus-folders)** - Adaptive folder icons for Material theming

### Wayland System Integration
- **[wlogout](https://github.com/ArtsyMacaw/wlogout)** - Wayland-native logout menu with customizable power management options
- **[waybar](https://github.com/Alexays/Waybar)** - Highly customizable Wayland bar for Sway and Wlroots-based compositors

### Related Projects
- **[Niri Flake](https://github.com/sodiboo/niri-flake)** - NixOS integration for Niri compositor
- **[Hyprland](https://hyprland.org/)** - Alternative dynamic tiling Wayland compositor
