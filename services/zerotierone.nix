{ ... }: {
  networking.firewall.allowedUDPPorts = [ 9993 ];
  services.zerotierone.enable = true;
}
