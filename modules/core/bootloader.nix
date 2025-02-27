{diskPath}: {lib, ...}: {
  boot = {
    loader = {
      grub = {
        enable = lib.mkForce true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        # Will be set to "device" by disko
        devices = ["nodev"];
      };
    };
  };
}
