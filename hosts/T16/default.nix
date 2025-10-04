{pkgs, ...}: {
  imports = [
    ../../system/hardware/hardware-configuration.nix
  ];

  # Host-specific configuration
  networking.hostName = "T16";
  
  # Set your time zone (preserving existing setting)
  time.timeZone = "Asia/Dubai";

  # Select internationalisation properties  
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

  # Display Manager - using SDDM for Hyprland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable X11 for XWayland support
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable dconf for GTK applications
  programs.dconf.enable = true;

  # Additional system packages specific to this host
  environment.systemPackages = with pkgs; [
    bitwarden
    fprintd
    libfprint
  ];

  # VMware guest additions (if running in VM)
  virtualisation.vmware.guest.enable = false; # Disable if not in VM

  # System services specific to this host
  services.dbus.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # System state version
  system.stateVersion = "25.11";
}
