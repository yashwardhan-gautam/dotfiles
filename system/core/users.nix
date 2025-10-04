{pkgs, ...}: {
  # Enhanced user management
  users.users.unalome = {
    isNormalUser = true;
    description = "unalome";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video" 
      "input"
      "uucp"          # Serial devices
      "dialout"       # Modem access
      "cdrom"         # Optical drives
      "scanner"       # Scanner access
      "lp"            # Printer access
      "wireshark"     # Network analysis
    ];
    shell = pkgs.fish;
    
    # User packages (system-wide tools)
    packages = with pkgs; [
      # User utilities
      firefox
      git
      curl
      wget
    ];
  };
  
  # Enable fish shell system-wide
  programs.fish.enable = true;
  
  # Enable additional user services
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # Set default shell
  users.defaultUserShell = pkgs.fish;
  
  # Enable locate for file searching
  services.locate = {
    enable = true;
  };
}