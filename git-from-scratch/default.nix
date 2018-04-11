let
  inherit (import <nixpkgs> {}) lib;
  fetcher = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  versions = lib.mapAttrs
    (_: fetcher)
    (builtins.fromJSON (builtins.readFile ../.nix/versions.json));
  # ./updater versions.json ihaskell
  IHaskell = versions.ihaskell;
  # ./updater versions.json nixpkgs nixos-17.09
  pinned   = versions.nixpkgs;
in import "${IHaskell}/release.nix" {
  nixpkgs = import pinned {};
  packages = self: with self; [
    SHA
    attoparsec
    base16-bytestring
    byteable
    bytestring
    containers
    directory
    filepath
    utf8-string
    zlib
  ];
  systemPackages = pkgs: with pkgs; [
    coreutils
    findutils
    git
    qpdf
  ];
}
