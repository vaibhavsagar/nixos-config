{config, pkgs, agenix, ...}: {
  programs.ssh = let
    ipAddress = builtins.readFile config.age.secrets.uptrust-cache-ip-address.path;
  in {
    extraConfig = ''
      Host uptrust-nix-cache
        Hostname ${ipAddress}
        Port 38299
        User nix-ssh
        IdentityFile /home/vaibhavsagar/.ssh/id_ed25519
    '';

    knownHosts = {
      uptrust-nix-cache-ed25519 = {
        hostNames = [ ipAddress ];
        publicKeyFile = config.age.secrets.uptrust-cache-ed25519-public-key.path;
      };

      uptrust-nix-cache-rsa = {
        hostNames = [ ipAddress ];
        publicKeyFile = config.age.secrets.uptrust-cache-rsa-public-key.path;
      };
    };
  };
  nix.settings.substituters = [
    "https://nixcache.reflex-frp.org"
    "ssh://uptrust-nix-cache"
  ];
  nix.settings.trusted-public-keys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    (builtins.readFile config.age.secrets.uptrust-cache-trusted-public-key.path)
  ];
}
