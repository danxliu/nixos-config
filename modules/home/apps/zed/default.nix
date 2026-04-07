{
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    userSettings = builtins.fromJSON (builtins.readFile ./zed-settings.json);
  };
}
