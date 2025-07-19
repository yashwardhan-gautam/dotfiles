# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{
  pkgs,
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
  time.timeZone = "Etc/UTC";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # Display Manager - using SDDM for Hyprland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

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

  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Security services
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  # Enable fish shell
  programs.fish.enable = true;

  # Enable dconf for GTK applications
  programs.dconf.enable = true;

  users.users.unalome = {
    isNormalUser = true;
    description = "unalome";
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    lazygit
    curl
    fzf
    ripgrep
    fd
    firefox
    ghostty
    tmux
    xclip
    fish
    wget
    starship
    git
    btop
    brave
    zoxide
    gcc15
    gnumake
    cmake
    ninja
    pkg-config
    obsidian
    lua5_1
    luajitPackages.luarocks
    lua-language-server
    stylua
    python312
    python312Packages.pip
    go
    cargo
    xclip
    clang
    clang-tools
    codespell
    cppcheck
    doxygen
    code-cursor
    tree-sitter
    telegram-desktop
    gemini-cli

    # Development libraries for flox project
    gtest
    gbenchmark

    # System services and daemons
    docker_28
    postgresql_16
    redis
    conda

    # Essential system utilities
    xclip # Needed for X11 clipboard in XWayland
  ];

  # System services
  services.dbus.enable = true;
  services.gvfs.enable = true; # For nautilus
  services.tumbler.enable = true; # Thumbnails

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Fonts (system-wide)
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  # Environment variables
  environment.sessionVariables = {
    # Wayland
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    # Qt
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    # GTK
    GDK_BACKEND = "wayland,x11";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";

    # Electron
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  virtualisation.vmware.guest.enable = true;
  services.openssh.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
