{ ... }:
{
  programs.cava = {
    enable = true;
    
    settings = {
      general = {
        framerate = 180;
        sensitivity = 100;
        bars = 0;
        bar_width = 3;
        bar_spacing = 2;
      };

      input = {
        method = "pipewire";
        source = "auto";
      };

      output = {
        method = "ncurses";
      };

      color = {
        gradient = 1;
        gradient_color_1 = "'#b7bdf8'";
        gradient_color_2 = "'#b7bdf8'";
      };
    };
  };
}
