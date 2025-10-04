{inputs, ...}: {
  flake.homeConfigurations = {
    unalome = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [../];
    };
  };
}