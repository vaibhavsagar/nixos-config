{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.haskellPackages.override {
      overrides = self: super: {
        extra = self.callHackage "extra" "1.6.6" {};
        hlint = self.callHackage "hlint" "2.1.10" {};
        haskell-src-exts = super.haskell-src-exts_1_20_2;
      };
    }).hlint
  ];
}
