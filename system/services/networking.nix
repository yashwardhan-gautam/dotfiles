{
  # Enable networking
  networking.networkmanager.enable = true;
  
  # Hostname
  networking.hostName = "T16";
  
  # Enable SSH daemon
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}