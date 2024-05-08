{pkgs, ...}: {
  services.xserver.dpi = 180;

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };
}
