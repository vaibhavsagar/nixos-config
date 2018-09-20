{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.haskellPackages.override {
      all-cabal-hashes = pkgs.fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/20cb236627a294ea4f44cb4851e833876a9978d2.tar.gz";
        sha256 = "158av4y9ihq6301b0ym40r68ldwf8h8gy9a054r0n7qi6blgv2al";
      };
      overrides = self: super: {
        ghcid = self.callHackage "ghcid" "0.7.1" {};
        extra = self.callHackage "extra" "1.6.6" {};
      };
    }).ghcid
  ];
}
