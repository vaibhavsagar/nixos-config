{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.haskellPackages.override {
      all-cabal-hashes = pkgs.fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/22cb611adaf63739fc7e3956d83d450154ec766b.tar.gz";
        sha256 = "0wxggabwz8qs2hmnr3k3iwy9rmvicx4a1n22l7f6krk1hym5bkpl";
      };
      overrides = self: super: {
        extra = self.callHackage "extra" "1.6.6" {};
        hlint = self.callHackage "hlint" "2.1.10" {};
        haskell-src-exts = super.haskell-src-exts_1_20_2;
      };
    }).hlint
  ];
}
