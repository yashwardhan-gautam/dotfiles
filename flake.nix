{
  description = "unalome nixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

     hyprland = {
       url = "github:hyprwm/Hyprland";
       inputs.nixpkgs.follows = "nixpkgs";
     };

     niri = {
       url = "github:YaLTeR/niri";
       inputs.nixpkgs.follows = "nixpkgs";
     };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    hyprland,
    zen-browser,
    ...
  } @ inputs: let
    # Helper function to create a NixOS configuration
    mkNixOSConfig = {
      machine ? "T16",
      windowManager ? "cosmic",
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs windowManager;};
        system = "x86_64-linux";
        modules = [
          (import ./hosts/${machine}/default.nix)
          home-manager.nixosModules.home-manager
           {
             nixpkgs.overlays = [
               (final: prev: {
                 niri = inputs.niri.packages.${prev.system}.default.overrideAttrs (_: {
                   doCheck = false;
                 });
               })
             ];
             home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs windowManager;};
            home-manager.backupFileExtension = "backup";
            home-manager.users.unalome = import ./home/default.nix;
          }
        ];
      };
  in {
    # Default configuration (COSMIC)
    nixosConfigurations.T16 = mkNixOSConfig {
      machine = "T16";
      windowManager = "cosmic";
    };

    # COSMIC variant (explicit)
    nixosConfigurations.T16-cosmic = mkNixOSConfig {
      machine = "T16";
      windowManager = "cosmic";
    };

    # Hyprland variant
    nixosConfigurations.T16-hyprland = mkNixOSConfig {
      machine = "T16";
      windowManager = "hyprland";
    };

    # Niri variant (future)
    nixosConfigurations.T16-niri = mkNixOSConfig {
      machine = "T16";
      windowManager = "niri";
    };

    # Standalone home-manager configuration
    homeConfigurations.unalome = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [./home/default.nix];
    };
  };
}
