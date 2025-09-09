# AMD GPU configuration
{config, pkgs, ...}: {
  # Enable OpenGL (this is still needed for AMD)
  hardware.graphics = {
    enable = true;

    enable32Bit = true;

    # extraPackages32 = with pkgs; [
    #   driversi686Linux.amdvlk
    # ];
    
    extraPackages = with pkgs; [
      amdvlk
      #rocm-opencl-icd
      #rocm-opencl-runtime
      mesa
      rocmPackages.clr.icd
    ];
  };

  # Load AMD driver for Xorg and Wayland
  services.xserver.videoDrivers = ["amdgpu"];

  # AMD specific configuration
  hardware.amdgpu = {
    # Enable AMDGPU kernel module
    amdvlk.enable = true;
    
    # Enable GPU reset support (useful for recovery)
    # reset.enable = true;
  };

  # Optional: Enable Vulkan support
  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
  };

  boot.kernelParams = [
  "amdgpu.ppfeaturemask=0xffffffff"
  "amdgpu.gpu_recovery=1"
  "video=DP-1:2560x1440@60"
  "video=DP-2:1920x1080@144"
  ];

  boot.initrd.kernelModules = ["amdgpu"];
}
