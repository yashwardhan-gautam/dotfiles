{pkgs, ...}: {
  # PipeWire audio with enhanced configuration
  services.pulseaudio.enable = false;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    # Enhanced audio configuration
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
        default.clock.allowed-rates = [44100 48000 88200 96000];
      };
    };
    
    # WirePlumber configuration for better device handling
    wireplumber.enable = true;
  };

  # Additional audio packages
  environment.systemPackages = with pkgs; [
    # Audio tools and utilities
    pavucontrol
    playerctl
    pamixer
    # Codec support
    pulseaudio
  ];
}