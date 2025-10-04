{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./stylix.nix
    ./gtk.nix
    ./theme-manager.nix
    ./app-themes.nix
  ];
}