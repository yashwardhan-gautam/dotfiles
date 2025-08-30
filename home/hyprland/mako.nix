{...}: {
  services.mako = {
    enable = true;

    settings = {
      # Gruvbox Light theme colors - Retro groove color scheme
      # https://github.com/morhetz/gruvbox
      background-color = "#fbf1c7";
      text-color = "#3c3836";
      border-color = "#458588";
      progress-color = "#b16286";

      width = 420;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 2;
      border-radius = 0;

      anchor = "top-right";
      layer = "overlay";

      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";

      group-by = "app-name";

      actions = true;

      format = "<b>%s</b>\\n%b";
      markup = true;
    };
  };
}
