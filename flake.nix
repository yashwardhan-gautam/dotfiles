{
  description = "unalome nixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    zen-browser,
    ...
  } @ inputs: let
    # Helper function to create a NixOS configuration
    mkNixOSConfig = {
      machine ? "T16",
    }: nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        (import ./hosts/${machine}/default.nix)
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.backupFileExtension = "backup";
          home-manager.users.unalome = import ./home/default.nix;
        }
      ];
    };
  in {
    # COSMIC configuration
    nixosConfigurations.T16-cosmic = mkNixOSConfig {
      machine = "T16";
    };

    # Standalone home-manager configuration
    homeConfigurations.unalome = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [./home/default.nix];
    };
  };
}
