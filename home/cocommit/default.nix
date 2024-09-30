{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = [
    (pkgs.callPackage ../../pkgs/cocommit {})
  ];

  # Must be installed manually
  # Might not be needed as cocommit creates its own author file
  #xdg.configFile.kitty = {
    #source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/cocommit/");
 # };
}
