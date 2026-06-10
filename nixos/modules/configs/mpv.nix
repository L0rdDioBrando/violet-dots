{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
    ];

    config = {
      save-position-on-quit = true;
      keep-open = "yes";
      cursor-autohide = 1500;
      screenshot-format = "webp";
      screenshot-webp-lossless = "yes";
      osc = "no";
      osd-bar = "no";
      profile = "gpu-hq";
      scale = "box";
      cscale = "mitchell";
      video-sync = "display-resample";
      interpolation = "yes";
    };

    bindings = {
      "l" = "seek 5";
      "h" = "seek -5";
      "k" = "add volume 2";
      "j" = "add volume -2";
      "K" = "add volume 10";
      "J" = "add volume -10";
      "[" = "add speed -0.25";
      "]" = "add speed 0.25";
      "\\" = "set speed 1.0";
      "m" = "script-binding uosc/menu";
      "MBTN_RIGHT" = "script-binding uosc/menu";
      "s" = "script-binding uosc/subtitles";
      "a" = "script-binding uosc/audio";
      "p" = "script-binding uosc/items";
      "f" = "cycle fullscreen";
      "MBTN_LEFT_DBL" = "cycle pause";
      "F11" = "cycle fullscreen";
      "SPACE" = "cycle pause";
      "r" = "cycle loop-file";
      "ctrl+r" = "cycle-values video-rotate 90 180 270 0";
      "S" = "screenshot";
      "alt+s" = "screenshot video";
      "v" = "cycle sub-visibility";
      "ctrl+c" = ''run "sh" "-c" "echo ''\${time-pos} | wl-copy"'';
      "_" = "cycle video";
    };
  };

  home.file.".config/mpv/script-opts/uosc.conf".text = ''
    timeline_size=32
    languages=ru,en
    click_threshold=250
  '';
}
