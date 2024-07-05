{diskPath}: {
  lib,
  pkgs,
  ...
}: {
  imports = [
    # A desktop is just a server with better UX right?
    (import ./core-server.nix {diskPath = diskPath;})

    # services
    ./services/pulseaudio.nix
    ./services/printing.nix
    ./services/security.nix
    ./services/shell.nix
    ./services/xdg.nix

    # configs
    ./configs/fonts.nix
    ./configs/i3.nix
    ./configs/programs.nix
    ./configs/user-groups.nix
  ];

  nixpkgs.config.allowUnfree = lib.mkForce true;

  environment.systemPackages = with pkgs; [
    parted
    (python3.withPackages (
      ps:
        with pkgs; [
          # Add packages that need root here
        ]
    ))
  ];

  # Disable sleep for desktop to try to avoid window freezes
  # Due to inactivity
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services = {
    dbus.packages = [pkgs.gcr];
    xserver.monitorSection = ''
    VendorName     "Unknown"
    ModelName      "Ancor Communications Inc VG248"
    HorizSync       30.0 - 160.0
    VertRefresh     50.0 - 150.0
    Option         "DPMS"
    '';
    xserver.deviceSection = ''
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "NVIDIA GeForce RTX 2070 SUPER"
    '';
    xserver.screenSection = ''
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-0"
    Option         "metamodes" "DP-0: 1920x1080_144 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: nvidia-auto-select +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
    '';
    # xserver.xrandrHeads = [
    #  {
    #    output = "DP-0";
    #    primary = true;
    #    monitorConfig = "VertRefresh 144-144";
    #  }
    #  {
    #    monitorConfig = ''
    #      Option "Enable" "true"
    #    '';
    #    output = "DP-2";
    #  }
    # ];
  };
}
