{
  config,
  variables,
  ...
}: {
  xdg.configFile.aerospace = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/darwin/aerospace/config");
  };
}
