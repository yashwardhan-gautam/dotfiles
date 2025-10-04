{
  # Power management for laptop using power-profiles-daemon
  services.upower.enable = true;
  
  # Power Profiles Daemon for dynamic power management
  services.power-profiles-daemon.enable = true;
  
  # Disable TLP since we're using power-profiles-daemon with custom monitor
  services.tlp.enable = false;
}