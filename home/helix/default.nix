
{
  pkgs,
  config,
  variables,
  ...
}: {
  home.packages = with pkgs; [
    helix
  ];  
      
  xdg.configFile.helix = {
    source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfilesLocation}" + (builtins.toPath "/home/helix/config");
  };
}
