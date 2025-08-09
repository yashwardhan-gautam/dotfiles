{...}: {
  programs.yazi = {
    enable = true;
    # Provide a convenient shell alias wrapper name `y`, if desired later
    # shellWrapperName = "y";

    # Minimal, sensible defaults; users can extend in ~/.config/yazi if needed
    settings = {
      mgr = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };

    enableFishIntegration = true;
  };
}
