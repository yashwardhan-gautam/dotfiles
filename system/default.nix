let
  desktop = [
    ./core
    ./hardware
    ./nix
    ./programs
    ./services
  ];

  laptop =
    desktop
    ++ [
      # Laptop-specific additions are already included in the base modules
    ];
in {
  inherit desktop laptop;
}