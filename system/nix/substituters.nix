{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://chaotic-nyx.cachix.org/"
      "https://cuda-maintainers.cachix.org"
      "https://numtide.cachix.org"
    ];
    
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPiCgBv/baULW8kHHavN7mLnbQJjwLCRI="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy2Ik+aJgEBHt8EoWcjJJa8hOG+Y8="
    ];
    
    # Additional settings for substituters
    extra-substituters = [];
    extra-trusted-public-keys = [];
    
    # Builder settings
    builders-use-substitutes = true;
  };
}