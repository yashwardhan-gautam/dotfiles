{pkgs, ...}: {
  home.packages = with pkgs; [
    code-cursor
  ];

  # Cursor (VSCode-based) configuration
  xdg.configFile."Cursor/User/settings.json".text = ''
    {
      "workbench.colorTheme": "Gruvbox Dark Hard",
      "editor.fontFamily": "JetBrainsMono Nerd Font",
      "editor.fontSize": 14,
      "editor.fontLigatures": true,
      "editor.formatOnSave": true,
      "editor.tabSize": 2,
      "editor.insertSpaces": true,
      "editor.trimAutoWhitespace": true,
      "files.trimTrailingWhitespace": true,
      "files.insertFinalNewline": true,
      "editor.rulers": [100],
      "editor.wordWrap": "bounded",
      "editor.wordWrapColumn": 100,
      "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font",
      "terminal.integrated.fontSize": 13,
      "terminal.integrated.defaultProfile.linux": "fish",
      "git.enableSmartCommit": true,
      "git.confirmSync": false,
      "extensions.autoUpdate": false,
      "telemetry.telemetryLevel": "off",
      "workbench.startupEditor": "none"
    }
  '';
}