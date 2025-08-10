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
    };
    interactiveShellInit = ''
      set -U fish_greeting
      set -x EDITOR "nvim"
      set -x VISUAL "nvim"
    '';
  };
}
