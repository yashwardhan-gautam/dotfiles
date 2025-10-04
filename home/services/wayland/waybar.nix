{config, lib, ...}: let
  # Default colors (Tokyo Night theme)
  backgroundRgb = "rgb(26, 27, 38)";
  foregroundRgb = "rgb(192, 202, 245)";
  
  # Extract font size from primary_font and scale it
  fontSize = lib.toInt (lib.last (lib.splitString " " config.dotfiles.primary_font));
  scaledFontSize = fontSize + 4; # Waybar typically uses slightly larger font
  
  # Extract font family from primary_font
  fontFamily = lib.removeSuffix " ${toString fontSize}" config.dotfiles.primary_font;
in {
  home.file = {
    ".config/waybar/style.css" = {
      text = ''
        @define-color background ${backgroundRgb};
        @define-color foreground ${foregroundRgb};

        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: ${fontFamily};
          font-size: ${toString scaledFontSize}px;
          color: ${foregroundRgb};
        }

        window#waybar {
          background-color: ${backgroundRgb};
        }

        #workspaces {
          margin-left: 7px;
        }

        #workspaces button {
          all: initial;
          padding: 2px 6px;
          margin-right: 3px;
        }

        #workspaces button:hover {
          background-color: rgba(192, 202, 245, 0.08);
          border-radius: 6px;
        }

        #workspaces button.active {
          background-color: rgba(192, 202, 245, 0.12);
          border-radius: 6px;
        }

        #custom-dropbox,
        #cpu,
        #power-profiles-daemon,
        #battery,
        #network,
        #bluetooth,
        #wireplumber,
        #backlight,
        #tray,
        #clock {
          background-color: transparent;
          min-width: 12px;
          margin-right: 13px;
        }

        tooltip {
          padding: 2px;
        }

        tooltip label {
          padding: 2px;
        }
      '';
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "cpu"
          "bluetooth"
          "network"
          "wireplumber"
          "backlight"
          "power-profiles-daemon"
          "battery"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };
          # No persistent workspaces - only show workspaces as they are created
        };
        cpu = {
          interval = 10;
          format = "󰍛";
          on-click = "ghostty -e btop";
        };
        clock = {
          format = "{:%d-%B, %I:%M %p}";
          format-alt = "{:%A}";
          tooltip = false;
        };
        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "nm-connection-editor";
        };
        battery = {
          interval = 5;
          format = "{capacity}% {icon}";
          format-discharging = "{capacity}% {icon}";
          format-charging = "{capacity}% {icon}";
          format-plugged = "{capacity}% ";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "Charged 󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          states = {
            warning = 20;
            critical = 10;
          };
        };
        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        wireplumber = {
          format = "󰕾 {volume}%";
          format-muted = "󰝟 {volume}%";
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip-format = "Playing at {volume}%";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          max-volume = 150;
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          tooltip-format = "Brightness: {percent}%";
        };
        tray = {spacing = 13;};
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}";
          tooltip = true;
          format-icons = {
            power-saver = "󰡳";
            balanced = "󰊚";
            performance = "󰡴";
          };
        };
      }
    ];
  };
}
