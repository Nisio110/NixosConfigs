{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    # -- Basic Settings ------------------------------------------
    prefix = "C-f";
    escapeTime = 10;          # set -sg escape-time 10 (vim-friendly)
    historyLimit = 5000;
    baseIndex = 1;            # sets both base-index and pane-base-index
    mouse = true;
    keyMode = "vi";           # setw -g mode-keys vi
    reverseSplit = true;
    terminal = "tmux-256color";

    # prevent sensible overriding my config
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
      resurrect
      vim-tmux-navigator
      sidebar
    ];

    # Anything without a dedicated programs.tmux.* option goes here.
    # Note: home-manager appends extraConfig at the END of tmux.conf,
    # after the options block but before plugins are loaded.
    extraConfig = ''
      # Extra Plugins
      set -g @plugin 'graemedavidson/tmux-pane-focus

      # -- Basic Settings (no dedicated HM option) ----------------
      set -g set-clipboard on
      set -g mode-style "fg=default,bg=default,reverse"
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # Truecolor passthrough: tell tmux the outer terminal handles RGB SGR.
      # tmux-256color itself is only a 256-colour terminfo; without this the
      # 24-bit colours omp emits get quantised to the 256-colour palette.
      set -as terminal-features ",xterm-kitty:RGB"
      set -as terminal-features ",xterm-ghostty:RGB"
      set -as terminal-features ",xterm-256color:RGB"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind '"' split-window -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"

      # -- Vi mode ------------------------------------------------
      # 'v' to begin selection
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      # 'y' to yank
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      # Make Enter behave like 'y'
      unbind-key -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel

      # -- Design Tweaks ------------------------------------------
      # don't do anything when a 'bell' rings
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # clock mode
      setw -g clock-mode-colour red

      # copy mode (note: this overrides the mode-style set above)
      setw -g mode-style 'fg=black bg=red bold'

      # panes
      set -g pane-border-style 'fg=blue dim'
      set -g pane-active-border-style 'fg=red'
      set -g @pane-focus-enabled on

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=red'

      set -g status-left '''
      set -g status-left-length 10

      set -g status-right-style 'fg=red'
      set -g status-right '#S | %Y-%m-%d - %H:%M | #H '
      set -g status-right-length 50

      setw -g window-status-current-style 'fg=red'
      setw -g window-status-current-format '#I[#W]#F '

      setw -g window-status-style 'fg=red'
      setw -g window-status-format '#I[#W]#F '

      setw -g window-status-bell-style 'fg=yellow bg=red bold'

      # messages
      set -g message-style 'fg=red'
    '';
  };
}
