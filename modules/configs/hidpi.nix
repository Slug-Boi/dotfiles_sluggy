{...}: {
  services = {
    xserver.dpi = 92;

    displayManager.sddm.enableHidpi = true;
  };

  #environment.variables = {
  #  GDK_SCALE = "2";
  #  GDK_DPI_SCALE = "0.5";
  #  QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  #};
}
