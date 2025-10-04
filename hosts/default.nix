{inputs, ...}: {
  flake.nixosConfigurations = {
    T16 = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./T16
        inputs.chaotic.nixosModules.default
      ] ++ (import ../system).laptop;
    };
  };
}