{
  description = "Freds minimal Nixos configuration flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Comprehensive NixOS framework - provides pre-configured modules for system components
    hydenix = {
      url = "github:richen604/hydenix";
    };
    
    # Firefox browser extensions packaged for Nix - enables declarative Firefox addon management
    rycee-nurpkgs = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Database for comma tool and command-not-found functionality
    # Enables running software without installing it first and provides command suggestions
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # UEFI Secure Boot implementation for NixOS - currently commented out
    # Uncomment when you want to enable secure boot functionality
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    
  };


  outputs = { self, nixpkgs, home-manager, hydenix, rycee-nurpkgs, nix-index-database, ...} @ inputs: {
    # T16 NixOS Configuration
    nixosConfigurations.T16 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        (import ./hosts/T16/default.nix)
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.unalome = import ./home/default.nix;
        }
      ];
    };
  };
}
