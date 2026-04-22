{ pkgs, theme, ... }:
{
  xdg.configFile = {
    "nvim/snippets".source = ./nvim/snippets;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      conform-nvim
      luasnip
      nvim-lspconfig
      blink-cmp
      mini-pick
      nvim-web-devicons
      dashboard-nvim
      nvim-colorizer-lua
      vimtex
      lualine-nvim
      nvim-tree-lua
      indent-blankline-nvim
      gitsigns-nvim
      nvim-autopairs
      nvim-ts-autotag
      base16-nvim
    ];
    extraPackages = with pkgs; [
      # LSPs
      clang-tools
      pyright
      jdt-language-server
      typescript-language-server
      vscode-langservers-extracted
      rust-analyzer
      nixd
      texlab
      marksman
      lua-language-server
      bash-language-server
      yaml-language-server
      svelte-language-server
      tailwindcss-language-server
      emmet-language-server
      harper

      # Formatters & Linters
      nixfmt
      black
      shellcheck
      prettierd
      stylua
      shfmt
      ruff
    ];
    initLua = theme.replaceText (builtins.readFile ./nvim/init.lua);
  };
}
