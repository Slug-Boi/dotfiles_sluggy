{
  config,
  variables,
  ...
}: {
  xdg.configFile.raycast = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/darwin/raycast/config");
  };
}
