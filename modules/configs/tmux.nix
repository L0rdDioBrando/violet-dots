{ ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    extraConfig = ''
      # Options to make tmux more pleasant
      set -g mouse on
      set -g default-terminal "tmux-256color"
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # New binds
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Delete binds
      unbind %
      unbind '"'

      # Configure the catppuccin plugin
      set -g @catppuccin_flavor "macchiato"
      set -g @catppuccin_window_status_style "rounded"

      # Load catppuccin
      run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
      # For TPM, instead use `run ~/.tmux/plugins/tmux/catppuccin.tmux`
      set -agF status-right "#{E:@catppuccin_status_cpu}"

      set -g @plugin 'tmux-plugins/tmux-cpu'

      # Make the status line pretty and add some modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"

      # Or, if using TPM, just run TPM
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
