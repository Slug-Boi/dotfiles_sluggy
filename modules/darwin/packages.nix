{ pkgs }:


with pkgs;
let shared-packages = import ../shared/home.nix { inherit pkgs; }; in
shared-packages ++ [
  dockutil
]
