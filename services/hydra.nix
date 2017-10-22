{ config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 3000 ];
  services.hydra = {
    enable = true;
    hydraURL = "http://128.199.234.106";
    notificationSender = "hydra@vaibhavsagar.com";
    useSubstitutes = true;
  };
}
