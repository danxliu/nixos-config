{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.github-vscode-theme
        pkief.material-icon-theme
        vscodevim.vim
        esbenp.prettier-vscode
        ms-python.python
        vscjava.vscode-java-pack
        bbenoist.nix
        Google.gemini-cli-vscode-ide-companion
        ms-toolsai.jupyter
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
  };
}
