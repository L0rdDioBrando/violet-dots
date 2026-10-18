{
  pkgs,
  lib,
  config,
  ...
}:
{
  # GTK theme
  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    theme = {
      name = "catppuccin-macchiato-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = lib.mkForce (
        pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "lavender";
        }
      );
    };
  };

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
    qt6ctSettings = {
      Appearance = {
        color_scheme = "catppuccin-macchiato-lavender";
        icon_theme = "Papirus-Light";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = "\"FiraCode Nerd Font,12,-1,5,300,0,0,0,0,0,0,0,0,0,0,1\"";
        general = "\"FiraCode Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular\"";
      };
      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 3;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 4;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      PaletteEditor = {
        geometry = "@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1\0\0\0\0\0\0\0\0\a\x80\0\0\x2\x14\0\0\0\xb1\0\0\x5\x1d\0\0\x2\xc1)";
      };
      SettingsWindow = {
        geometry = "@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3\0\0\0\0\0\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\aL\0\0\x3\xe3)";
      };
      Troubleshooting = {
        force_raster_widgets = 2;
        ignored_applications = "@Invalid()";
      };
    };
    kvantum = {
      enable = true;
      settings.General = {
        theme = "catppuccin-macchiato-lavender";
      };
    };
    kde.settings.kdeglobals = {
      "ColorEffects:Disabled" = {
        Color = "36, 39, 58";
        ColorAmount = 0.30000000000000004;
        ColorEffect = 2;
        ContrastAmount = 0.1;
        ContrastEffect = 0;
        IntensityAmount = "-1";
        IntensityEffect = 0;
      };
      "ColorEffects:Inactive" = {
        ChangeSelectionColor = false;
        Color = "36, 39, 58";
        ColorAmount = 0.5;
        ColorEffect = 3;
        ContrastAmount = 0;
        ContrastEffect = 0;
        Enable = true;
        IntensityAmount = 0;
        IntensityEffect = 0;
      };
      "Colors:Button" = {
        BackgroundAlternate = "183, 189, 248";
        BackgroundNormal = "54, 58, 79";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      "Colors:Complementary" = {
        BackgroundAlternate = "24, 25, 38";
        BackgroundNormal = "30, 32, 48";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      "Colors:Header" = {
        BackgroundAlternate = "24, 25, 38";
        BackgroundNormal = "30, 32, 48";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      "Colors:Selection" = {
        BackgroundAlternate = "183, 189, 248";
        BackgroundNormal = "183, 189, 248";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "17, 17, 27";
        ForegroundInactive = "17, 17, 27";
        ForegroundLink = "17, 17, 27";
        ForegroundNegative = "17, 17, 27";
        ForegroundNeutral = "17, 17, 27";
        ForegroundNormal = "17, 17, 27";
        ForegroundPositive = "17, 17, 27";
        ForegroundVisited = "17, 17, 27";
      };
      "Colors:Tooltip" = {
        BackgroundAlternate = "24, 25, 38";
        BackgroundNormal = "36, 39, 58";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      "Colors:View" = {
        BackgroundAlternate = "30, 32, 48";
        BackgroundNormal = "36, 39, 58";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      "Colors:Window" = {
        BackgroundAlternate = "24, 25, 38";
        BackgroundNormal = "30, 32, 48";
        DecorationFocus = "183, 189, 248";
        DecorationHover = "73, 77, 100";
        ForegroundActive = "245, 169, 127";
        ForegroundInactive = "165, 173, 203";
        ForegroundLink = "183, 189, 248";
        ForegroundNegative = "237, 135, 150";
        ForegroundNeutral = "238, 212, 159";
        ForegroundNormal = "202, 211, 245";
        ForegroundPositive = "166, 218, 149";
        ForegroundVisited = "198, 160, 246";
      };
      General = {
        ColorScheme = "Catppuccin Macchiato Lavender";
        ColorSchemePath = "Catppuccin Macchiato Lavender.colors";
        XftHintStyle = "hintslight";
        XftSubPixel = "rgb";
        fixed = "FiraCode Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
        font = "FiraCode Nerd Font Mono,24,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
        menuFont = "FiraCode Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
        smallestReadableFont = "FiraCode Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
        toolBarFont = "FiraCode Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
      };
      Icons.Theme = "Papirus-Dark";
      KDE = {
        contrast = 4;
        frameContrast = 0.2;
        widgetStyle = "kvantum";
      };
      WM = {
        activeBackground = "36,39,58";
        activeBlend = "202,211,245";
        activeFont = "FiraCode Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,,0,0";
        activeForeground = "202,211,245";
        inactiveBackground = "24,25,38";
        inactiveBlend = "165,173,203";
        inactiveForeground = "165,173,203";
      };
    };
  };

  # Import custom Kvantum theme
  xdg.configFile = {
    "Kvantum/catppuccin-macchiato-lavender/".source = ./configs/kvantum;
  };
}
