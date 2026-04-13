{
  pkgs,
  config,
  variables,
  ...
}: {

  xdg.configFile.ghostty = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/ghostty/config");
  };
}

