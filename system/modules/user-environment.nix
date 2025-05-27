{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    code-cursor # Assuming this is the intended package name for VS Code or a similar editor
  #  wget
  ];

  # Programs settings
  # Install firefox.
  programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Services settings
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # List other services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable command-not-found service
  # programs.command-not-found.enable = true; # Note: This is often in programs, but fits services context too

  # Users settings
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.unalome = {
    isNormalUser = true;
    description = "unalome";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
} 