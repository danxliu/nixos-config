{ pkgs, config, ... }:
let
  colors = config.colorScheme.palette;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/nvim-treesitter.lua;
      }
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/luasnip.lua;
      }
      nvim-lspconfig
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/blink-cmp.lua;
      }
      {
        plugin = mini-pick;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/mini-pick.lua;
      }
      nvim-web-devicons
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/dashboard.lua;
      }
      {
        plugin = nvim-colorizer-lua;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/colorizer.lua;
      }
      vimtex
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/lualine.lua;
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/nvim-tree.lua;
      }
      indent-blankline-nvim
      gitsigns-nvim
      {
        plugin = mini-base16;
        type = "lua";
        config = ''
          require("mini.base16").setup({
            palette = {
              base00 = "#${colors.base00}",
              base01 = "#${colors.base01}",
              base02 = "#${colors.base02}",
              base03 = "#${colors.base03}",
              base04 = "#${colors.base04}",
              base05 = "#${colors.base05}",
              base06 = "#${colors.base06}",
              base07 = "#${colors.base07}",
              base08 = "#${colors.base08}",
              base09 = "#${colors.base09}",
              base0A = "#${colors.base0A}",
              base0B = "#${colors.base0B}",
              base0C = "#${colors.base0C}",
              base0D = "#${colors.base0D}",
              base0E = "#${colors.base0E}",
              base0F = "#${colors.base0F}"
            }
          })
        '';
      }
    ];
    initLua = builtins.readFile ./nvim/init.lua;
  };
}
