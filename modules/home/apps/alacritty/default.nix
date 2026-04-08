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
          # Primary colors
          primary.background = "#${colors.base00}";
          primary.foreground = "#${colors.base05}";

          # Normal colors
          normal.black   = "#${colors.base00}";
          normal.red     = "#${colors.base08}";
          normal.green   = "#${colors.base0B}";
          normal.yellow  = "#${colors.base0A}";
          normal.blue    = "#${colors.base0D}";
          normal.magenta = "#${colors.base0E}";
          normal.cyan    = "#${colors.base0C}";
          normal.white   = "#${colors.base05}";

          # Bright colors
          bright.black   = "#${colors.base03}";
          bright.red     = "#${colors.base08}";
          bright.green   = "#${colors.base0B}";
          bright.yellow  = "#${colors.base0A}";
          bright.blue    = "#${colors.base0D}";
          bright.magenta = "#${colors.base0E}";
          bright.cyan    = "#${colors.base0C}";
          bright.white   = "#${colors.base07}";
        };
      };
    };
  };
}
