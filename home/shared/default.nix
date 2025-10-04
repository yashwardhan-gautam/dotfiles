{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./stylix.nix
    ./gtk.nix
  ];
}