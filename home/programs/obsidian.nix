{pkgs, ...}: {
  # Ensure obsidian package is available (already in system packages)
  home.packages = with pkgs; [
    obsidian
  ];

  # Create desktop entry for Obsidian
  xdg.desktopEntries.obsidian = {
    name = "Obsidian";
    comment = "A powerful knowledge base that works on top of a local folder of plain text Markdown files";
    exec = "obsidian";
    icon = "obsidian";
    terminal = false;
    type = "Application";
    categories = ["Office" "Utility"];
  };
}
