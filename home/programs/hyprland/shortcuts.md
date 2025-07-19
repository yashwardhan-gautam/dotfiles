# Hyprland Shortcuts Reference

This document lists all configured keyboard shortcuts for Hyprland.

**Main Modifier Key:** `Super` (Windows key)

## 🚀 Application Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + T` | Open Terminal | Opens Ghostty terminal |
| `Super + C` | Open Terminal + Editor | Opens Ghostty with Neovim |
| `Super + E` | Open File Manager | Opens Nautilus file manager |
| `Super + R` | Open App Menu | Opens Rofi application launcher |
| `Super + B` | Open Browser | Opens Firefox browser |

## 🪟 Window Management

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + Q` | Close Window | Kills the active window |
| `Super + M` | Exit Hyprland | Exits the window manager |
| `Super + V` | Toggle Floating | Toggles window between tiled and floating |
| `Super + P` | Pseudo Tile | Dwindle layout pseudo-tiling |
| `Super + J` | Toggle Split | Toggles split direction in dwindle layout |
| `Super + Shift + Enter` | Toggle Fullscreen | Makes window fullscreen |

## 🧭 Focus Navigation

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + ←` | Focus Left | Move focus to left window |
| `Super + →` | Focus Right | Move focus to right window |
| `Super + ↑` | Focus Up | Move focus to upper window |
| `Super + ↓` | Focus Down | Move focus to lower window |

## 📋 Workspace Navigation

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + 1` | Workspace 1 | Switch to workspace 1 |
| `Super + 2` | Workspace 2 | Switch to workspace 2 |
| `Super + 3` | Workspace 3 | Switch to workspace 3 |
| `Super + 4` | Workspace 4 | Switch to workspace 4 |
| `Super + 5` | Workspace 5 | Switch to workspace 5 |
| `Super + 6` | Workspace 6 | Switch to workspace 6 |
| `Super + 7` | Workspace 7 | Switch to workspace 7 |
| `Super + 8` | Workspace 8 | Switch to workspace 8 |
| `Super + 9` | Workspace 9 | Switch to workspace 9 |
| `Super + 0` | Workspace 10 | Switch to workspace 10 |

## 📦 Move Windows to Workspaces

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + Shift + 1` | Move to Workspace 1 | Move active window to workspace 1 |
| `Super + Shift + 2` | Move to Workspace 2 | Move active window to workspace 2 |
| `Super + Shift + 3` | Move to Workspace 3 | Move active window to workspace 3 |
| `Super + Shift + 4` | Move to Workspace 4 | Move active window to workspace 4 |
| `Super + Shift + 5` | Move to Workspace 5 | Move active window to workspace 5 |
| `Super + Shift + 6` | Move to Workspace 6 | Move active window to workspace 6 |
| `Super + Shift + 7` | Move to Workspace 7 | Move active window to workspace 7 |
| `Super + Shift + 8` | Move to Workspace 8 | Move active window to workspace 8 |
| `Super + Shift + 9` | Move to Workspace 9 | Move active window to workspace 9 |
| `Super + Shift + 0` | Move to Workspace 10 | Move active window to workspace 10 |

## 🖱️ Mouse Bindings

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + Mouse Wheel Up` | Previous Workspace | Scroll to previous workspace |
| `Super + Mouse Wheel Down` | Next Workspace | Scroll to next workspace |
| `Super + Left Mouse Button` | Move Window | Drag to move window |
| `Super + Right Mouse Button` | Resize Window | Drag to resize window |

## 📸 Screenshots

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + S` | Area Screenshot | Select area and edit with Swappy |
| `Super + Shift + S` | Full Screenshot | Capture full screen and edit with Swappy |

## 🔊 Audio Controls

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Volume Up` | Increase Volume | Increase system volume by 5% |
| `Volume Down` | Decrease Volume | Decrease system volume by 5% |
| `Volume Mute` | Toggle Mute | Toggle system audio mute |

## 🔆 Brightness Controls

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Brightness Up` | Increase Brightness | Increase screen brightness by 5% |
| `Brightness Down` | Decrease Brightness | Decrease screen brightness by 5% |

## 🎵 Media Controls

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Media Play/Pause` | Play/Pause | Toggle media playback |
| `Media Next` | Next Track | Skip to next track |
| `Media Previous` | Previous Track | Skip to previous track |

## 🔒 System Controls

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Super + L` | Lock Screen | Lock the screen with Hyprlock |

---

## 📝 Configuration Files

- **Main Config**: `~/.config/hypr/hyprland.conf`
- **Keybindings**: `~/.config/hypr/keybindings.conf`
- **Monitors**: `~/.config/hypr/monitors.conf`
- **User Preferences**: `~/.config/hypr/userprefs.conf`

## 🛠️ Customization

To modify these shortcuts, edit the `keybindings.conf` file in your Hyprland configuration directory.

**Variables used:**
- `$mainMod = SUPER` (Windows key)
- `$terminal = ghostty`
- `$fileManager = nautilus`
- `$menu = rofi -show drun`
- `$browser = brave`
- `$editor = nvim`

## 📚 Resources

- [Hyprland Wiki - Keybindings](https://wiki.hyprland.org/Configuring/Binds/)
- [Hyprland Wiki - Dispatchers](https://wiki.hyprland.org/Configuring/Dispatchers/) 