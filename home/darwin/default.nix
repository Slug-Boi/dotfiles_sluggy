{pkgs, ...}: {
  home.packages = with pkgs; [
    dockutil

    # virtualization tools
    vagrant
  ];
}
