{
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
    ./nh.nix
  ];

  # Enhanced Nix settings
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];
      
      # Performance optimizations
      max-jobs = "auto";
      cores = 0; # Use all cores
      
      # Store optimizations
      keep-outputs = true;
      keep-derivations = true;
      
      # Security
      allowed-users = ["@wheel"];
      sandbox = true;
      
      # Build settings
      build-users-group = "nixbld";
      warn-dirty = false;
      
      # Download settings
      connect-timeout = 5;
      stalled-download-timeout = 90;
      
      # Logging
      log-lines = 25;
    };
    
    # Garbage collection (nh handles this)
    gc = {
      automatic = false; # Let nh handle this
    };
    
    # Auto-optimize store weekly
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    
    # Extra build inputs
    distributedBuilds = false; # Enable if you have remote builders
  };
  
  # Enable documentation
  documentation = {
    enable = true;
    nixos.enable = true;
    man.enable = true;
    dev.enable = true;
  };
}