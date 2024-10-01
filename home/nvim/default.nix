{
  pkgs,
  config,
  dotfilesLocation,
  ...
}: {
  home.packages = with pkgs; [
    curl # for vimplug
    virtualenv
    xclip
    stdenv.cc
    lua5_1
    lua51Packages.luarocks
    lua-language-server
    rust-analyzer
  ];  
      
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesLocation}" + (builtins.toPath "/home/nvim/config");
  };
}
