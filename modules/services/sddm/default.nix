{pkgs,...}: {
  imports = [
    ./theme.nix
  ];

  services = {
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = false;
      };
    };

    displayManager = {
      sessionPackages = [pkgs.hyprland];
      sddm = {
        enable = true;
        theme = "sddm-astronaut-theme";
      };
    }; 
  };
}
