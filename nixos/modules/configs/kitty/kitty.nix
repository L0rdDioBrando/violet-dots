{ ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 12;
    };

    settings = {
      # The basic colors
      foreground = "#cad3f5";
      background = "#24273a";
      selection_foreground = "#24273a";
      selection_background = "#f4dbd6";

      # Cursor colors
      cursor = "#f4dbd6";
      cursor_text_color = "#24273a";

      # Scrollbar colors
      scrollbar_handle_color = "#939ab7";
      scrollbar_track_color = "#494d64";

      # URL color when hovering with mouse
      url_color = "#b7bdf8";

      # Kitty window border colors
      active_border_color = "#b7bdf8";
      inactive_border_color = "#6e738d";
      bell_border_color = "#eed49f";

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = "#181926";
      active_tab_background = "#b7bdf8";
      inactive_tab_foreground = "#cad3f5";
      inactive_tab_background = "#1e2030";
      tab_bar_background = "#181926";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#24273a";
      mark1_background = "#b7bdf8";
      mark2_foreground = "#24273a";
      mark2_background = "#c6a0f6";
      mark3_foreground = "#24273a";
      mark3_background = "#7dc4e4";

      # The 16 terminal colors

      # Black
      color0 = "#494d64";
      color8 = "#5b6078";

      # Red
      color1 = "#ed8796";
      color9 = "#ed8796";

      # Green
      color2 = "#a6da95";
      color10 = "#a6da95";

      # Yellow
      color3 = "#eed49f";
      color11 = "#eed49f";

      # Blue
      color4 = "#8aadf4";
      color12 = "#8aadf4";

      # Magenta
      color5 = "#f5bde6";
      color13 = "#f5bde6";

      # Cyan
      color6 = "#8bd5ca";
      color14 = "#8bd5ca";

      # White
      color7 = "#b8c0e0";
      color15 = "#a5adcb";

      # Options
      scrollback_lines = 10000;
      bold_font        = "auto";
      italic_font      = "auto";
      bold_font_italic = "auto";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      update_check_interval = 0;
      font_features = "FiraCodeNFM-Reg +cv14 +ss04 +cv16 +cv30 +cv31 +cv25 +cv26 +cv32 +cv28 +cv29 +ss01 +ss05 +ss02 +ss03 +zero";
      tab_bar_style = "custom";
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_separator = "";

    };
  };
  xdg.configFile."kitty/tab_bar.py".source = ./tab_bar.py;
}
