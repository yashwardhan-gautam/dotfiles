{
  description = "unalome nixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

<<<<<<< Updated upstream
     hyprland = {
       url = "github:hyprwm/Hyprland";
       inputs.nixpkgs.follows = "nixpkgs";
     };

     niri = {
       url = "github:YaLTeR/niri";
       inputs.nixpkgs.follows = "nixpkgs";
     };
=======
>>>>>>> Stashed changes

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    dms,
    niri,
    ...
  } @ inputs: let
<<<<<<< Updated upstream
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
=======
    system = "x86_64-linux";
>>>>>>> Stashed changes
  in {
    nixosConfigurations.T16-niri = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = system; }
        (import ./hosts/T16/default.nix)
        dms.nixosModules.dankMaterialShell
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
          home-manager.users.unalome = import ./home/default.nix;
        }
      ];
    };

  };
}
