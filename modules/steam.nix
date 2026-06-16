{ config, pkgs, lib, ... }: {
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  programs.java.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    localNetworkGameTransfers.openFirewall = true;
    extraPackages = [ pkgs.hidapi ];
  };
}
