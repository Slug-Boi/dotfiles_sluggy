{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    sketchybar
  ];

  xdg.configFile.sketchybar = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/darwin/sketchybar/config");
  };
}
