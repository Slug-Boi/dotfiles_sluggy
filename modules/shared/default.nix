{ config, pkgs, ... }:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
      # packageOverrides = pkgs: {
      #   unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
      # };
    };
    #pkgs-unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};

    variables = import ../../variables.nix;
    theme = import ../../theme.nix;

    overlays =
      # Apply each overlay found in the /overlays directory
      let path = ../../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)));
  };
}
