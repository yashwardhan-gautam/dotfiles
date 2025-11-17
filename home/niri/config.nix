{config, lib, pkgs, ...}: 
let
  # Helper to get binary paths
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  polkit-agent = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
in
{
  xdg.configFile."niri/config.kdl".text = ''
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
        gaps 8
        
        center-focused-column "never"
        
        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }
        
        default-column-width { proportion 0.5; }
        
        focus-ring {
            width 2
            active-color "#7aa2f7"
            inactive-color "#3b4261"
        }
        
        border {
            width 2
            active-color "#7aa2f7"
            inactive-color "#3b4261"
        }
    }
    
    window-rule {
        geometry-corner-radius 8
        clip-to-geometry true
    }
    
    animations {
        slowdown 1.0
    }
    
    prefer-no-csd
    
    screenshot-path "~/Pictures/Screenshots/Screenshot-%Y-%m-%d-%H-%M-%S.png"
    
    environment {
        XDG_CURRENT_DESKTOP "niri"
        XDG_SESSION_TYPE "wayland"
        QT_QPA_PLATFORM "wayland"
        GDK_BACKEND "wayland"
        MOZ_ENABLE_WAYLAND "1"
    }
    
    spawn-at-startup "${nm-applet}"
    spawn-at-startup "${polkit-agent}"
    
    binds {
        Mod+Space { spawn "wofi" "--show" "drun"; }
        Mod+D { spawn "fuzzel"; }
        Mod+Return { spawn "ghostty"; }
        Mod+T { spawn "ghostty"; }
        Mod+E { spawn "thunar"; }
        
        Mod+Q { close-window; }
        Mod+F { maximize-column; }
        
        Mod+Left { focus-column-left; }
        Mod+H { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+L { focus-column-right; }
        Mod+Up { focus-window-up; }
        Mod+K { focus-window-up; }
        Mod+Down { focus-window-down; }
        Mod+J { focus-window-down; }
        
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+J { move-window-down; }
        
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        
        Print { screenshot; }
        Mod+Print { screenshot-screen; }
        
        XF86AudioRaiseVolume allow-when-locked=true { spawn "pamixer" "-i" "5"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "pamixer" "-d" "5"; }
        XF86AudioMute allow-when-locked=true { spawn "pamixer" "-t"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+5%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }
        
        Mod+Shift+E { quit; }
    }
  '';
}
