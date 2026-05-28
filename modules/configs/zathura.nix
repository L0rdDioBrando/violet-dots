{ ... }:

{
  programs.zathura = {
    enable = true;
    
    options = {
      font = "FiraCode Nerd Font 12";
      selection-clipboard = "clipboard";
      scroll-step = 60;
      adjust-open = "width";
    };

    mappings = {
      "J" = "navigate next";
      "K" = "navigate previous";
      "[Control]scroll_up" = "zoom in";
      "[Control]scroll_down" = "zoom out";
    };
  };
}
