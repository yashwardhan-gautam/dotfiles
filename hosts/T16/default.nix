# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "T16"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dubai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Audio setup
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # XDG portals are configured via Home Manager in `home/programs/xdg.nix`

  # Security services
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  # PAM fingerprint authentication
  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    su.fprintAuth = true;
  };

  # Enable fish shell
  programs.fish.enable = true;

  # Enable dconf for GTK applications
  programs.dconf.enable = true;

  users.users.unalome = {
    isNormalUser = true;
    description = "unalome";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "input" "docker"];
    shell = pkgs.fish;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    fprintd
    libfprint
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "libsoup-2.74.3" # Required by some GNOME applications, has known CVEs but needed for compatibility
    ];
  };

  # No Flameshot overlay (using Hyprshot instead)
  nixpkgs.overlays = [];

  # DankMaterialShell (DMS) configuration
  programs.dankMaterialShell = {
    enable = true;
    # package option removed as it does not exist
    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart when DMS changes
    };

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableClipboard = true;            # Clipboard history manager
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
  };

  # System services
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # Fingerprint authentication
  services.fprintd.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  virtualisation.vmware.guest.enable = true;
  services.openssh.enable = true;

  # Docker configuration
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  system.stateVersion = "26.05";
}
