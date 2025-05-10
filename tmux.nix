{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    terminal = "tmux-256color";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      # Focus events
      set-option -g focus-events on

      # Display time
      set-option -g display-time 3000

      # Colors
      set -g terminal-overrides ",xterm-256color:RGB"

      # General settings
      set -g detach-on-destroy off
      set -g renumber-windows on
      set -g set-clipboard on
      set -g status-interval 3

      # Status bar configuration
      set -g status-left "#[fg=blue,bold]#S"
      set -ga status-left " #[fg=white,nobold]#(gitmux -cfg $HOME/.config/tmux/gitmux.yml)"
      set -g status-left-length 200
      set -g status-position top
      set -g status-right ""
      set -g status-style "bg=default"

      # Window status format
      set -g window-status-current-format "👉#[fg=magenta]#W"
      set -g window-status-format "  #[fg=gray]#W"

      # Key bindings
      bind '%' split-window -c "#{pane_current_path}" -h
      bind '"' split-window -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      bind g new-window -n "🌳" lazygit
      bind G new-window -n "😺" ghd
      bind B new-window -n "👷" b
      bind D new-window -n "👷" d
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Copy mode key bindings
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key x kill-pane
      bind-key e send-keys "tmux capture-pane -p -S - | nvim -c 'set buftype=nofile' +" Enter

      # Plugin settings
      set -g @fzf-url-fzf-options "-p 60%,30% --prompt=\"  \" --border-label=\" Open URL \""
      set -g @fzf-url-history-limit "2000"
      set -g @t-bind "T"
      set -g @t-fzf-find-binding "ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)"
      set -g @t-fzf-prompt " "
      set -g @tmux-last-color on
      set -g @tmux-last-pager "less -r"
      set -g @tmux-last-pager "less"
      set -g @tmux-last-prompt-pattern " "
      set -g @tmux-nerd-font-window-name-shell-icon ""
      set -g @tmux-nerd-font-window-name-show-name false
      set -g @thumbs-command "echo -n {} | pbcopy"
      set -g @thumbs-key C
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
    ];
  };
} 