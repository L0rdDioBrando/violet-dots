{ ... }:
let
  lavender = "#b7bdf8";
  blue = "blue";
  cyan = "cyan";
in
{
  programs.fastfetch = {
    enable = true;
    settings = { 
      logo = {
        source = "${./ascii.txt}"; 
        padding = {
          top = 2;
          left = 0;
          right = 2;
        };
        color = {
          "1" = lavender;
        };
      };
      display = {
        separator = ": ";
        key = {
          width = 14;
          type = "string";
        };
      };
      modules = [
        {
          type = "custom";
          format = "{#34}┌ OS ────────────────────────────{#}";
        }
        {
          type = "os";
          key = "├─ os";
          keyColor = blue;
          format = "{name} {version}";
        }
        {
          type = "kernel";
          key = "├─ kernel";
          keyColor = blue;
        }
        {
          type = "shell";
          key = "└─ shell";
          keyColor = blue;
        }
        "break"
        {
          type = "custom";
          format = "{#36}┌ HARDWARE ──────────────────────{#}";
          keyColor = cyan;
        }
        { type = "display"; key = "├─ display"; keyColor = cyan; }
        { type = "cpu"; key = "├─ cpu"; keyColor = cyan; }
        { type = "gpu"; key = "├─ gpu"; keyColor = cyan; }
        { type = "disk"; key = "├─ disk"; keyColor = cyan; }
        { type = "memory"; key = "└─ memory"; keyColor = cyan; }
        "break"
        {
          type = "custom";
          format = "{#${lavender}}┌ APPEARANCE ────────────────────{#}";
          keyColor = cyan;
        }
        { type = "de"; key = "├─ de"; keyColor = lavender; }
        { type = "wm"; key = "├─ wm"; keyColor = lavender; }
        {
          type = "theme";
          key = "├─ theme";
          format = "catppuccin-macchiato-lavender [Qt]";
          keyColor = lavender;
        }
        { type = "cursor"; key = "├─ cursor"; keyColor = lavender; }
        { type = "icons"; key = "├─ icons"; keyColor = lavender; }
        { type = "font"; key = "├─ font"; keyColor = lavender; }
        { type = "terminal"; key = "├─ terminal"; keyColor = lavender; }
        { type = "media"; key = "└─ music"; keyColor = lavender; }
        {
          type = "colors";
          symbol = "circle";
          block = { width = 1; };
        }
      ];
    };
  };
}
