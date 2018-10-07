{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.haskellPackages.hlint
  ];
}
