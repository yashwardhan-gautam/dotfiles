# Niri Migration Action Plan
## Complete Migration from Hyprland to Niri with DankMaterialShell

---

## Overview

This action plan details the migration from Hyprland to Niri compositor with DankMaterialShell (DMS), while preserving Cosmic DE as an alternative. The default will be Niri, with GDM managing both desktop sessions.

---

## Phase 1: Update Flake Configuration

### Objective
Modify the flake to add Niri and DMS inputs, remove Hyprland, and restructure configuration variants.

### Files Modified
- `flake.nix`

### Detailed Actions

1. **Remove Hyprland Input** (lines 10-13)
   ```nix
   # REMOVE:
   hyprland = {
     url = "github:hyprwm/Hyprland";
     inputs.nixpkgs.follows = "nixpkgs";
   };
   ```

2. **Add Niri and DMS Inputs**
   ```nix
   # ADD after zen-browser input:
   niri-flake = {
     url = "github:sodiboo/niri-flake";
     inputs.nixpkgs.follows = "nixpkgs";
   };
   
   dgop = {
     url = "github:AvengeMedia/dgop";
     inputs.nixpkgs.follows = "nixpkgs";
   };
   ```

3. **Update Outputs Parameters**
   - Remove `hyprland` from outputs destructuring
   - Add `niri-flake` and `dgop`
   ```nix
   outputs = {
     nixpkgs,
     home-manager,
     niri-flake,
     dgop,
     zen-browser,
     ...
   }
   ```

4. **Change Default Configuration**
   ```nix
   # CHANGE from:
   nixosConfigurations.T16 = mkNixOSConfig {
     machine = "T16";
     windowManager = "cosmic";
   };
   
   # TO:
   nixosConfigurations.T16 = mkNixOSConfig {
     machine = "T16";
     windowManager = "niri";
   };
   ```

5. **Update Configuration Variants**
   ```nix
   # KEEP:
   nixosConfigurations.T16-cosmic = mkNixOSConfig {
     machine = "T16";
     windowManager = "cosmic";
   };
   
   # REPLACE T16-hyprland with T16-niri:
   nixosConfigurations.T16-niri = mkNixOSConfig {
     machine = "T16";
     windowManager = "niri";
   };
   ```

6. **Pass Niri/DMS to Modules**
   - Add `niri-flake` and `dgop` to `specialArgs` in `mkNixOSConfig`

### Expected Outcome
Flake will build Niri-based configuration by default, with Cosmic available as T16-cosmic variant.

---

## Phase 2: Update System Configuration

### Objective
Enable Niri at the system level, switch from SDDM to GDM, and remove Hyprland system configuration.

### Files Modified
- `hosts/T16/default.nix`

### Detailed Actions

1. **Remove Hyprland Configuration** (lines 42-47)
   ```nix
   # DELETE:
   programs.hyprland = lib.mkIf (windowManager == "hyprland") {
     enable = true;
     package = inputs.hyprland.packages.${pkgs.system}.hyprland;
     xwayland.enable = true;
   };
   ```

2. **Add Niri Configuration**
   ```nix
   # ADD:
   programs.niri = lib.mkIf (windowManager == "niri") {
     enable = true;
     package = pkgs.niri-unstable;
   };
   
   # Enable xwayland-satellite for Niri
   programs.xwayland-satellite = lib.mkIf (windowManager == "niri") {
     enable = true;
   };
   ```

3. **Replace Display Manager Configuration** (lines 54-63)
   ```nix
   # REPLACE with:
   services.displayManager = {
     # Use GDM for both Niri and Cosmic
     gdm = lib.mkIf (windowManager == "niri" || windowManager == "cosmic") {
       enable = true;
       wayland = true;
     };
   };
   
   # Keep cosmic-greeter only as fallback
   services.displayManager.cosmic-greeter = lib.mkIf (windowManager == "cosmic") {
     enable = lib.mkDefault false; # GDM takes precedence
   };
   ```

4. **Add Required System Services**
   ```nix
   # ADD for DMS support:
   services.dbus.packages = lib.mkIf (windowManager == "niri") [
     pkgs.gcr
   ];
   
   # Ensure necessary portals are available
   xdg.portal = lib.mkIf (windowManager == "niri") {
     enable = true;
     extraPortals = with pkgs; [
       xdg-desktop-portal-gnome
       xdg-desktop-portal-gtk
     ];
     config.common.default = "*";
   };
   ```

### Expected Outcome
System will boot with GDM, offering both Niri and Cosmic sessions. Niri will be default.

---

## Phase 3: Create Niri Home Configuration Structure

### Objective
Create a well-organized directory structure for Niri configuration, mirroring the clean organization from the reference repositories.

### Files Created
- `home/niri/default.nix`
- `home/niri/config.nix`
- `home/niri/dms.nix`
- `home/niri/bindings.nix`
- `home/niri/startup.nix`
- `home/niri/environment.nix`
- `home/niri/wallpapers/` (directory)

### Detailed Actions

1. **Create Directory Structure**
   ```bash
   mkdir -p home/niri/wallpapers
   ```

2. **Create `home/niri/default.nix`**
   ```nix
   {pkgs, ...}: {
     imports = [
       ./config.nix
       ./dms.nix
       ./bindings.nix
       ./startup.nix
       ./environment.nix
     ];
   
     # Install Niri-specific packages
     home.packages = with pkgs; [
       # Core Niri
       niri-unstable
       xwayland-satellite
       
       # DankMaterialShell
       # (will be added via dgop flake)
       
       # Wayland utilities
       wl-clipboard
       cliphist
       wf-recorder
       slurp
       grim
       swappy
       wlr-randr
       
       # System utilities
       brightnessctl
       pamixer
       playerctl
       pavucontrol
       
       # Portals
       xdg-desktop-portal-gnome
       xdg-desktop-portal-gtk
       
       # Cursor themes
       adwaita-icon-theme
       
       # Qt Wayland support
       qt5.qtwayland
       qt6.qtwayland
       
       # Network and system tray
       networkmanagerapplet
       
       # Authentication
       polkit_gnome
       
       # Additional utilities
       wireplumber
     ];
   }
   ```

3. **Create `home/niri/config.nix`**
   - This will generate the main Niri config.kdl file
   ```nix
   {config, lib, ...}: {
     xdg.configFile."niri/config.kdl".text = ''
       // Niri Configuration with DankMaterialShell
       
       input {
           keyboard {
               xkb {
                   layout "us"
               }
           }
           
           touchpad {
               tap
               natural-scroll
               dwt
               dwtp
           }
           
           mouse {
               natural-scroll false
           }
       }
       
       layout {
           gaps 5
           background-color "transparent"
           
           center-focused-column "never"
           
           preset-column-widths {
               proportion 0.33333
               proportion 0.5
               proportion 0.66667
           }
           
           default-column-width { proportion 0.5; }
       }
       
       // Layer rules for DMS
       layer-rule {
           match namespace="^quickshell$"
           place-within-backdrop true
       }
       
       layer-rule {
           match namespace="dms:blurwallpaper"
           place-within-backdrop true
       }
       
       // Window rules
       window-rule {
           geometry-corner-radius 8
           clip-to-geometry true
       }
       
       // Animations
       animations {
           slowdown 1.0
           
           horizontal-view-movement {
               spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
           }
           
           window-open {
               spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
           }
           
           config-notification-open-close {
               spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
           }
       }
       
       // Monitor configuration
       ${lib.concatMapStringsSep "\n" (monitor: ''
         output "${monitor}" {
             mode "${monitor}"
         }
       '') config.dotfiles.monitors}
       
       // Prefer no server-side decorations
       prefer-no-csd
       
       screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
     '';
   }
   ```

4. **Create `home/niri/bindings.nix`**
   ```nix
   {config, ...}: {
     xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
       binds {
           // DankMaterialShell Keybindings
           
           Mod+Space hotkey-overlay-title="Application Launcher" {
               spawn "dms" "ipc" "call" "spotlight" "toggle";
           }
           
           Mod+V hotkey-overlay-title="Clipboard Manager" {
               spawn "dms" "ipc" "call" "clipboard" "toggle";
           }
           
           Mod+M hotkey-overlay-title="Task Manager" {
               spawn "dms" "ipc" "call" "processlist" "toggle";
           }
           
           Mod+Comma hotkey-overlay-title="Settings" {
               spawn "dms" "ipc" "call" "settings" "toggle";
           }
           
           Mod+N hotkey-overlay-title="Notification Center" {
               spawn "dms" "ipc" "call" "notifications" "toggle";
           }
           
           Mod+Y hotkey-overlay-title="Browse Wallpapers" {
               spawn "dms" "ipc" "call" "dankdash" "wallpaper";
           }
           
           Mod+Alt+L hotkey-overlay-title="Lock Screen" {
               spawn "dms" "ipc" "call" "lock" "lock";
           }
           
           // Media keys
           XF86AudioRaiseVolume allow-when-locked=true {
               spawn "dms" "ipc" "call" "audio" "increment" "3";
           }
           
           XF86AudioLowerVolume allow-when-locked=true {
               spawn "dms" "ipc" "call" "audio" "decrement" "3";
           }
           
           XF86AudioMute allow-when-locked=true {
               spawn "dms" "ipc" "call" "audio" "mute";
           }
           
           XF86MonBrightnessUp allow-when-locked=true {
               spawn "dms" "ipc" "call" "brightness" "increment" "5" "";
           }
           
           XF86MonBrightnessDown allow-when-locked=true {
               spawn "dms" "ipc" "call" "brightness" "decrement" "5" "";
           }
           
           // Window management
           Mod+Q { close-window; }
           Mod+F { maximize-column; }
           Mod+Shift+F { fullscreen-window; }
           
           // Focus movement
           Mod+Left { focus-column-left; }
           Mod+Right { focus-column-right; }
           Mod+Up { focus-window-up; }
           Mod+Down { focus-window-down; }
           
           // Window movement
           Mod+Shift+Left { move-column-left; }
           Mod+Shift+Right { move-column-right; }
           Mod+Shift+Up { move-window-up; }
           Mod+Shift+Down { move-window-down; }
           
           // Workspace switching
           Mod+1 { focus-workspace 1; }
           Mod+2 { focus-workspace 2; }
           Mod+3 { focus-workspace 3; }
           Mod+4 { focus-workspace 4; }
           Mod+5 { focus-workspace 5; }
           
           // Move to workspace
           Mod+Shift+1 { move-window-to-workspace 1; }
           Mod+Shift+2 { move-window-to-workspace 2; }
           Mod+Shift+3 { move-window-to-workspace 3; }
           Mod+Shift+4 { move-window-to-workspace 4; }
           Mod+Shift+5 { move-window-to-workspace 5; }
           
           // Terminal
           Mod+Return { spawn "ghostty"; }
           
           // Screenshot
           Print { screenshot; }
           Mod+Print { screenshot-window; }
       }
     '';
   }
   ```

5. **Create `home/niri/startup.nix`**
   ```nix
   {config, ...}: {
     xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
       // Startup applications
       spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"
       spawn-at-startup "dms" "run"
       spawn-at-startup "nm-applet" "--indicator"
       spawn-at-startup "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
     '';
   }
   ```

6. **Create `home/niri/environment.nix`**
   ```nix
   {config, ...}: {
     xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
       environment {
           XDG_CURRENT_DESKTOP "niri"
           XDG_SESSION_TYPE "wayland"
           QT_QPA_PLATFORM "wayland"
           ELECTRON_OZONE_PLATFORM_HINT "auto"
           QT_QPA_PLATFORMTHEME "gtk3"
           QT_QPA_PLATFORMTHEME_QT6 "gtk3"
           GDK_BACKEND "wayland"
           SDL_VIDEODRIVER "wayland"
           CLUTTER_BACKEND "wayland"
       }
     '';
   }
   ```

7. **Create `home/niri/dms.nix`**
   ```nix
   {pkgs, dgop, ...}: {
     # DankMaterialShell configuration
     # This will be expanded based on dgop flake structure
     
     home.packages = [
       # DMS will be provided via dgop flake
     ];
     
     # DMS config directory setup
     xdg.configFile."dms/.keep".text = "";
   }
   ```

### Expected Outcome
Complete Niri home configuration structure with modular organization, ready for customization.

---

## Phase 4: Migrate Wallpapers

### Objective
Preserve existing wallpapers and make them available to DMS.

### Files Affected
- `home/hyprland/wallpapers/*` → `home/niri/wallpapers/*`

### Detailed Actions

1. **Copy Wallpaper Files**
   ```bash
   cp home/hyprland/wallpapers/*.{jpg,png} home/niri/wallpapers/
   ```

   Files to copy:
   - everforest.jpg
   - gruv-focus.png
   - gruv.jpg
   - gruvbox_minimal_space.png
   - gruvbox_minimal_space2.png
   - macos.jpg
   - starry-sky.png

2. **Update DMS Wallpaper Configuration**
   - DMS will auto-discover wallpapers in `~/.config/dms/wallpapers/`
   - Create symlink or copy to DMS config:
   ```nix
   # In home/niri/dms.nix:
   xdg.configFile."dms/wallpapers".source = ./wallpapers;
   ```

### Expected Outcome
All wallpapers preserved and accessible via DMS wallpaper browser.

---

## Phase 5: Update Home Manager Entry Point

### Objective
Modify home configuration to conditionally load Niri instead of Hyprland.

### Files Modified
- `home/default.nix`

### Detailed Actions

1. **Update Conditional Import** (line 13)
   ```nix
   # CHANGE from:
   ] ++ lib.optionals (windowManager == "hyprland") [
     ./hyprland
   
   # TO:
   ] ++ lib.optionals (windowManager == "niri") [
     ./niri
   ```

2. **Verify No Hyprland-Specific Packages Remain**
   - Ensure main packages list doesn't include Hyprland-only utilities
   - Keep shared tools: ghostty, yazi, wl-clipboard, etc.

### Expected Outcome
Home Manager will load Niri configuration when windowManager = "niri".

---

## Phase 6: Remove Hyprland Configuration

### Objective
Clean up Hyprland configuration after confirming Niri works.

### Files Deleted
- Entire `home/hyprland/` directory

### Detailed Actions

1. **Delete Hyprland Directory**
   ```bash
   rm -rf home/hyprland/
   ```

   This removes:
   - autostart.nix
   - bindings.nix
   - configuration.nix
   - default.nix
   - envs.nix
   - gestures.nix
   - hypridle.nix
   - hyprland.nix
   - hyprlock.nix
   - hyprpaper.nix
   - input.nix
   - looknfeel.nix
   - mako.nix
   - waybar.nix
   - windows.nix
   - wofi.nix
   - wallpapers/ (already migrated)

### Expected Outcome
Clean repository with no Hyprland configuration remnants.

---

## Phase 7: Update Generic Configuration Options

### Objective
Make configuration options window-manager agnostic.

### Files Modified
- `config.nix`

### Detailed Actions

1. **Update Monitor Option Description** (line 19)
   ```nix
   # CHANGE from:
   description = "Monitor configuration strings for Hyprland";
   
   # TO:
   description = "Monitor configuration strings for window manager";
   ```

2. **Verify All Options Are Generic**
   - Ensure no Hyprland-specific references remain
   - Keep options compatible with both Niri and Cosmic

### Expected Outcome
Configuration options usable by any window manager.

---

## Testing & Validation Plan

### Pre-Build Validation
1. Run `nix flake check` to validate syntax
2. Verify all imports resolve correctly
3. Check for circular dependencies

### Build Testing
1. Build Niri configuration: `sudo nixos-rebuild build --flake .#T16`
2. Build Cosmic configuration: `sudo nixos-rebuild build --flake .#T16-cosmic`
3. Verify no build errors

### System Testing
1. Switch to Niri: `sudo nixos-rebuild switch --flake .#T16`
2. Reboot system
3. Log in via GDM → Niri session
4. Test DMS features:
   - Mod+Space: Application launcher
   - Mod+V: Clipboard manager
   - Mod+N: Notification center
   - Mod+Y: Wallpaper browser
   - Media keys: Volume and brightness
5. Test Niri features:
   - Window tiling and scrolling
   - Workspace switching
   - Screenshot functionality
6. Test Cosmic session availability
7. Verify session switching at GDM

### Rollback Plan
If issues occur:
```bash
# Revert to previous generation
sudo nixos-rebuild switch --rollback

# Or boot into previous generation from boot menu
```

---

## Post-Migration Tasks

1. **Update Documentation**
   - Update README.md with Niri information
   - Document DMS keybindings
   - Add screenshots of new setup

2. **Cleanup**
   - Remove this action plan file after successful migration
   - Archive old Hyprland configs if desired

3. **Customization**
   - Adjust DMS theme via `dms ipc call settings toggle`
   - Configure wallpaper rotation
   - Fine-tune Niri animation timings
   - Set up workspace-specific rules

4. **Performance Optimization**
   - Monitor resource usage
   - Adjust animation slowdown if needed
   - Configure app-specific rules

---

## Reference Resources

- **Niri Documentation**: https://yalter.github.io/niri/
- **Niri GitHub**: https://github.com/YaLTeR/niri
- **DankMaterialShell Docs**: https://danklinux.com/docs/dankmaterialshell/
- **DMS GitHub**: https://github.com/AvengeMedia/dgop
- **Niri Flake**: https://github.com/sodiboo/niri-flake
- **Reference Dotfiles**:
  - https://github.com/skoove/dotfiles
  - https://github.com/JotaFab/s13los

---

## Summary

This migration will transform your system from Hyprland to a modern Niri + DankMaterialShell setup while preserving Cosmic as an alternative. The modular structure ensures maintainability, and GDM provides seamless session switching. The migration prioritizes clean organization inspired by the reference repositories, with all configurations managed declaratively through Nix.

