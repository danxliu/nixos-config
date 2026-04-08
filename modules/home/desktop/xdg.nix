{
  config, theme, ...
}:
let
  niriTemplate = builtins.readFile ../apps/niri/config.kdl;
in {
  xdg = {
    configFile = {
      "niri/config.kdl".text = theme.replaceText niriTemplate;
      "nvim/snippets/package.json".source = ../apps/neovim/nvim/snippets/package.json;
      "nvim/snippets/cpp.json".source = ../apps/neovim/nvim/snippets/cpp.json;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
