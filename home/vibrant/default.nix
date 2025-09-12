{pkgs, ...}: {
environment.systemPackages = [ pkgs.vibrantLinux ];
  
  # For system-wide service (optional):
  systemd.user.services.vibrantlinux = {
    description = "VibrantLinux";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.vibrantLinux}/bin/vibrantlinux";
      Restart = "always";
    };
  };
}
