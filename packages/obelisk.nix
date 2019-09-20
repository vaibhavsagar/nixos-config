{ pkgs, ... }: let
  fetcher = { owner, repo, rev, sha256, ... }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/tarball/${rev}";
  };
  obelisk = (fetcher (builtins.fromJSON (builtins.readFile ./versions.json)).obelisk);
in {
  environment.systemPackages = [
    (pkgs.callPackage obelisk {}).command
  ];
}
