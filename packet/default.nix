let
  fetcher = { owner, repo, rev, sha256, ... }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/tarball/${rev}";
  };
  nixpkgs = fetcher (builtins.fromJSON (builtins.readFile ./versions.json)).nixpkgs;
  nixos = import "${nixpkgs}/nixos" {
    configuration = import ./configuration.nix;
  };
in
  nixos.system
