{pkgs, ...}: {

  imports = [
    ../services/sddm
  ];

  programs.hyprland = { 
    enable = true; 
    xwayland.enable = true;
  };

  environment = {
    pathsToLink = ["/libexec"];
    systemPackages = [
      pkgs.kitty
    ];
  };
  


  # Possibly move these to ../services
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    libinput.enable = true;
};


}
