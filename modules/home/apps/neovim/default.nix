{ pkgs, ... }:

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
      github-nvim-theme
    ];
    initLua = builtins.readFile ./nvim/init.lua;
  };
}
