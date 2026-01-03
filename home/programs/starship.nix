{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = true;
    };
  };
}
