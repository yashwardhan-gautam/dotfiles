{
  description = "Freds minimal Nixos configuration flake.";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-cosmic, home-manager, ...} @ inputs: {
    nixosConfigurations.T16 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        (import ./configuration.nix)
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
        }
        nixos-cosmic.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.unalome = import ./home.nix;
        }
      ];
    };
  };
}


# flake             -> configuration.nix, home-manager.nix
# configuration.nix -> hardware-configuration.nix, cosmic.nix  (configuration.nix contains all packages installed)
# home-manager.nix  -> all dot files 