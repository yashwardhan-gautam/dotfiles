{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Import Hyprland home-manager module
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  # Install user-specific packages
  home.packages = with pkgs; [
    # Core Hyprland ecosystem
    hypridle
    hyprlock
    hyprpicker

    # Wayland utilities
    wl-clipboard
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

    # Launchers and menus
    rofi-wayland
    wofi

    # Wallpaper and theming
    swww
    qt5.qtwayland
    qt6.qtwayland

    # Notifications
    dunst
    libnotify

    # File manager
    nautilus

    # Network and system tray
    networkmanagerapplet
    blueman

    # Authentication
    polkit_gnome

    # Clipboard tools
    cliphist

    # Development tools (user-specific)
    lazygit
    fzf
    ripgrep
    fd
    btop
    htop
    zoxide
    tree-sitter

    # Applications
    firefox
    obsidian
    code-cursor
    telegram-desktop
    gemini-cli

    # Terminal utilities
    ghostty
    tmux
    fish
    starship
  ];

  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  # Copy configuration files
  home.file = {
    ".config/hypr/keybindings.conf".source = ./keybindings.conf;
    ".config/hypr/monitors.conf".source = ./monitors.conf;
    ".config/hypr/userprefs.conf".source = ./userprefs.conf;
    ".config/hypr/animations.conf".source = ./animations.conf;
    ".config/hypr/windowrules.conf".source = ./windowrules.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;

    # Scripts directory
    ".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };

    # Wallpapers
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };

  # Services
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 380;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };



  # XDG user directories
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "clock" "tray"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };

        "hyprland/window" = {
          max-length = 50;
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-bluetooth-muted = " {icon}";
          format-muted = " {icon}";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free Solid", "Font Awesome 6 Brands", "Font Awesome 6 Free Regular", "Roboto", "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-size: 13px;
        font-weight: bold;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 3px solid rgba(100, 115, 245, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      window#waybar.termite {
        background-color: #3F3F3F;
      }

      window#waybar.chromium {
        background-color: #000000;
        border: none;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
        border-bottom: 3px solid transparent;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.active {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd,
      #bluetooth,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd,
      #bluetooth {
        padding: 0 10px;
        margin: 0 4px;
        color: #ffffff;
      }

      label:focus {
        background-color: #000000;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }

      #pulseaudio.muted {
        background-color: #90b1b1;
      }

      #pulseaudio.source-muted {
        background-color: #f53c3c;
      }

      #wireplumber {
        background-color: #fff0f5;
        color: #000000;
      }

      #wireplumber.muted {
        background-color: #f53c3c;
      }

      #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }

      #pulseaudio.muted {
        background-color: #90b1b1;
      }

      #pulseaudio.source-muted {
        background-color: #f53c3c;
      }

      #wireplumber {
        background-color: #fff0f5;
        color: #000000;
      }

      #wireplumber.muted {
        background-color: #f53c3c;
      }

      #battery.charging, #battery.plugged {
        color: #ffffff;
        background-color: #26A65B;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';
  };
}
