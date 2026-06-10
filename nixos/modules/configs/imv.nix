{ ... }:

{
  programs.imv = {
    enable = true;
    
    settings = {
      options = {
        overlay = true;
        overlay_font = "FiraCode Nerd Font:12";
      };

      binds = {
        "l" = "next";
        "h" = "prev";
        "j" = "next";
        "k" = "prev";
        "q" = "quit";
        "f" = "fullscreen";
        "i" = "overlay";
      };
    };
  };
}
