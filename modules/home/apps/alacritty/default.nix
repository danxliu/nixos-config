{
  ...
}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general.live_config_reload = true;
      window.padding = {
        x = 20;
        y = 20;
      };
      font = {
        normal.family = "ZedMono NFM";
        size = 12;
        offset = {
          y = 8;
        };
        glyph_offset = {
          y = 4;
        };
      };
      terminal.shell.program = "tmux";
    };
    theme = "github_dark_default";
  };
}
