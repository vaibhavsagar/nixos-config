{ pkgs, ... }: let
  obelisk = pkgs.fetchFromGitHub {
    owner = "obsidiansystems";
    repo = "obelisk";
    rev = "ffce7c5f17e164f64cdae15895b30cefebbd7095";
    sha256 = "0hyhm9s52skmm7la06l1skg5casp3q0jympkg6k55qydh8ifshvx";
  };
in {
  environment.systemPackages = [
    (pkgs.callPackage obelisk {}).command
  ];
}
