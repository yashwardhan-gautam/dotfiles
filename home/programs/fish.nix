{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      nrb = "cd ~/dotfiles && sudo nixos-rebuild switch --flake .#T16";
      ncg = "sudo nix-collect-garbage -d";
      ndg3 = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3";
      gs = "git status";
      gd = "git diff";
      lg = "lazygit";
      ".." = "cd ..";
      "..." = "cd ../..";
      "vim" = "nvim";
      "v" = "nvim";
      "cd" = "z";
      "ls" = "eza";
      "ns" = "nix-shell --run fish";
      "nfu" = "nix flake update";
      "nfc" = "nix flake check";
      "b" = "bacon";
      "cat" = "bat";
    };
    interactiveShellInit = ''
      set -U fish_greeting
      set -x EDITOR "nvim"
      set -x VISUAL "nvim"

      # OpenSSL development headers for Rust crates
      # Home Manager packages are in home-manager-path, not .nix-profile
      set -x PKG_CONFIG_PATH "$HOME/.local/state/home-manager/gcroots/current-home/home-path/lib/pkgconfig" $PKG_CONFIG_PATH
    '';
  };
}
