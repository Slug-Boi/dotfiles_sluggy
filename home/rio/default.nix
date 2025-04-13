{
  config,
  variables,
  ...
}: {
   xdg.configFile.rio = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/rio/config");
  };
}
