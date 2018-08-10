{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.haskellPackages.override {
      all-cabal-hashes = pkgs.fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/ed2029405786768b4c0f8bdbbd7aee8193394eb9.tar.gz";
        sha256 = "0s6cbz7ylflpnqhxlpch48zb0l6xcp5501dj1qzvzldvwh46r8dc";
      };
      overrides = self: super: {
        extra = self.callHackage "extra" "1.6.6" {};
        hlint = self.callHackage "hlint" "2.1.8" {};
        haskell-src-exts = super.haskell-src-exts_1_20_2;
      };
    }).hlint
  ];
}
