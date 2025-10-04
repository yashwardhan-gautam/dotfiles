{pkgs, ...}: {
  # Enhanced security settings
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    
    # Enable sudo with fingerprint and enhanced security
    pam.services = {
      login.fprintAuth = true;
      sudo.fprintAuth = true;
      su.fprintAuth = true;
      # Hyprlock support
      hyprlock = {};
    };
    
    # Additional security features
    sudo.wheelNeedsPassword = true;
    sudo.execWheelOnly = true;
    
    # AppArmor for additional security
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };
  
  # Enhanced firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # Add specific ports as needed
    ];
    allowedUDPPorts = [
      # Add specific ports as needed
    ];
    # Disable ping for better security
    allowPing = false;
    # Log dropped packets for debugging
    logReversePathDrops = true;
  };
  
  # Additional security packages
  environment.systemPackages = with pkgs; [
    # Security tools
    usbguard
    clamav
    # System monitoring
    lsof
    htop
  ];
  
  # USB Guard for hardware security
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
  };
  
  # Enable fingerprint authentication service
  services.fprintd.enable = true;
}