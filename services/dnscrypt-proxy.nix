{
  networking.nameservers = [ "127.0.0.1" ];
  services.dnscrypt-proxy = {
    enable = true;
    resolverName = "cisco";
  };
}
