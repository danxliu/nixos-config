{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.apps.alacritty;
  colors = config.colorScheme.palette;
in
{
  options.apps.alacritty = {
    font = {
      name = mkOption {
        type = types.str;
        default = "ZedMono NFM";
      };
      size = mkOption {
        type = types.int;
        default = 12;
      };
    };
  };
  config = {
    programs.alacritty = {
      enable = true;
      settings = {
        general.live_config_reload = true;
        window.padding = {
          x = 20;
          y = 20;
        };
        font = {
          normal.family = "${cfg.font.name}";
          size = cfg.font.size;
          offset = {
            y = 8;
          };
          glyph_offset = {
            y = 4;
          };
        };
        terminal.shell.program = "tmux";
        colors = {
          primary.background = "#${colors.base00}";
          primary.foreground = "#${colors.base05}";
          normal.black = "#${colors.base00}";
          normal.red = "#${colors.base07}";
          normal.green = "#${colors.base0F}";
          normal.yellow = "#${colors.base0E}";
          normal.blue = "#${colors.base0B}";
          normal.magenta = "#${colors.base0D}";
          normal.cyan = "#${colors.base0C}";
          normal.white = "#${colors.base05}";
          bright.black = "#${colors.base03}";
          bright.red = "#${colors.base07}";
          bright.green = "#${colors.base0F}";
          bright.yellow = "#${colors.base0E}";
          bright.blue = "#${colors.base0B}";
          bright.magenta = "#${colors.base0D}";
          bright.cyan = "#${colors.base0C}";
          bright.white = "#${colors.base05}";
        };
      };
    };
  };
}
