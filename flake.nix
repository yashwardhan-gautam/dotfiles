{
  description = "Freds minimal Nixos configuration flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # UEFI Secure Boot implementation for NixOS
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    # T16 NixOS Configuration
    nixosConfigurations.T16 = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        (import ./hosts/T16/default.nix)
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

    # Standalone home-manager configuration
    homeConfigurations.T16 = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [./home/default.nix];
    };
  };
}
