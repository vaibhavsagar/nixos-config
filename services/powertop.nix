{ pkgs, ...}: {
  systemd.services.powertop = {
    description = ''
      enables powertop's reccomended settings on boot
    '';
    wantedBy = [ "multi-user.target" ];

    path = [ pkgs.powertop ];

    environment = {
      TERM = "dumb";
    };

    serviceConfig = {
      Type = "idle";
      User = "root";
      ExecStart = ''
        ${pkgs.powertop}/bin/powertop --auto-tune
      '';
    };
  };
}
