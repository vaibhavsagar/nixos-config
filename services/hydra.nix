{ config, pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 3000 ];
  nix.buildMachines = [
    {
      hostName = "localhost";
      systems = [ "i686-linux" "x86_64-linux" ];
      maxJobs = 1;
    }
  ];
  services.hydra = {
    enable = true;
    hydraURL = "http://128.199.234.106";
    minimumDiskFree = 1;
    minimumDiskFreeEvaluator = 1;
    notificationSender = "hydra@vaibhavsagar.com";
    useSubstitutes = true;
    extraConfig = ''
      store_uri = file:///var/lib/hydra/cache?secret-key=/etc/nix/128.199.234.106/nix-serve.sec
      binary_cache_secret_key_file=/etc/nix/128.199.234.106/nix-serve.sec
    '';
  };
}
