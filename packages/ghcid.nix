{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.haskellPackages.ghcid
  ];
}
