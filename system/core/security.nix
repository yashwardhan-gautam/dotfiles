{
  # Security settings
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    
    # Enable sudo with fingerprint
    pam.services = {
      login.fprintAuth = true;
      sudo.fprintAuth = true;
    };
  };
  
  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };
}