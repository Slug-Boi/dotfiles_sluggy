{
  pkgs,
  config,
  variables,
  cocommit,
  ...
}: {
  home.packages = [
    cocommit.packages.${pkgs.system}.default
  ];

  # Must be installed manually
  # Might not be needed as cocommit creates its own author file
  #xdg.configFile.kitty = {
    #source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/cocommit/");
 # };
}
