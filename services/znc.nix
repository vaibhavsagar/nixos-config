{
  services.znc = {
    enable = true;
    confOptions = {
      networks = {
        freenode = {
          channels = [ "haskell" "haskell-beginners" "nixos" "purescript" "qfpl" ];
          modules = [ "log" "simple_away" ];
          server = "chat.freenode.net";
          port = 6697;
          useSSL = true;
        };
      };
      nick = "vaibhavsagar";
      passBlock = ''
        <Pass password>
            Method = sha256
            Hash = 3e14c66fd4dfccc330e8e324bd794c6791ee03aa8c15816a6a48fd33d174ca98
            Salt = ft+O;OK3ABZkGj0dhZAq
        </Pass>
      '';
    };
  };
}
