# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{
  pkgs,
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

  # Enable COSMIC Desktop
  services.desktopManager.cosmic.enable = true;

  # Exclude unwanted COSMIC default applications
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit      # Text editor
    cosmic-term      # Terminal emulator
    cosmic-store     # App store
    cosmic-player    # Media player
  ];

  # Enable COSMIC greeter
  services.displayManager.cosmic-greeter.enable = true;

  # Enable X11 for XWayland support
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  # Security services
  security.polkit.enable = true;

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

  # Enable niri compositor (using nixpkgs version)
  programs.niri.enable = true;

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
    # COSMIC utilities
    tasks # Task management app for COSMIC
    quick-webapps # Web App Manager for COSMIC
    parabolic # YouTube downloader (yt-dlp frontend)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "libsoup-2.74.3" # Required by some GNOME applications, has known CVEs but needed for compatibility
    ];
  };

  nixpkgs.overlays = [];

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
