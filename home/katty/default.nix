{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = [
    (pkgs.callPackage ../../pkgs/kitty {})
  ];

  # Must be installed manually
  xdg.configFile.katty = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/katty/config");
  };
}
