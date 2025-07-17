{ pkgs, ... }: {
  # Configure Waybar (adapted from georgewhewell/nixos-host + omakub styling)
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font Propo", "Noto Sans", monospace;
        font-size: 12px;
        font-weight: 500;
      }

      box {
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }

      .modules-left {
        margin-left: 12px;
      }

      .modules-center {
        margin: 0;
      }

      .modules-right {
        margin-right: 12px;
      }

      #workspaces {
        background-color: #313244;
        border-radius: 5px;
        padding: 0 4px;
        margin: 0 6px;
      }

      #workspaces button {
        all: initial;
        padding: 4px 8px;
        margin: 2px 1px;
        background: transparent;
        color: #cdd6f4;
        border-radius: 3px;
        min-width: 20px;
      }

      #workspaces button.active {
        background-color: #89b4fa;
        color: #1e1e2e;
      }

      #workspaces button.urgent {
        background-color: #f38ba8;
        color: #1e1e2e;
      }

      #workspaces button:hover {
        background-color: #45475a;
      }

      #tray,
      #battery,
      #network,
      #bluetooth,
      #pulseaudio,
      #clock,
      #window {
        min-width: 20px;
        margin: 0 6px;
        padding: 4px 8px;
        background-color: #313244;
        border-radius: 5px;
      }

      #window {
        margin: 0 12px;
        padding: 4px 12px;
      }

      #battery {
        color: #89b4fa;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #network {
        color: #89dceb;
      }

      #pulseaudio {
        color: #cba6f7;
      }

      #clock {
        color: #fab387;
        font-weight: bold;
      }

      tooltip {
        padding: 6px;
        background-color: #1e1e2e;
        border: 1px solid #89b4fa;
        border-radius: 5px;
        color: #cdd6f4;
      }

      #tray {
        padding: 2px 6px;
      }
    '';
    settings = [{
      height = 32;
      layer = "top";
      position = "top";
      spacing = 6;
      tray = { 
        spacing = 8; 
        icon-size = 16;
      };
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "clock"
        "tray"
      ];
      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{name}";
        format-icons = {
          urgent = "";
          active = "";
          default = "";
        };
        on-click = "activate";
        sort-by-number = true;
        show-special = false;
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };

    }];
  };
} 