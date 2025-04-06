{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    zellij
  ];

  # xdg.configFile.zellij = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/zellij/config");
  # };
}
