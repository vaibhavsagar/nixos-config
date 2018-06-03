{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.haskellPackages.extend (self: super: {
      ghcid = self.callHackage "ghcid" "0.7" {};
      extra = self.callHackage "extra" "1.6.6" {};
    })).ghcid
  ];
}
