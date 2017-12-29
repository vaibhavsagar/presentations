let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  # ./updater versions.json ihaskell
  IHaskell = versions.ihaskell;
  # ./updater versions.json nixpkgs nixos-17.09
  pinned   = versions.nixpkgs;
in import "${IHaskell}/release.nix" {
  nixpkgs = import pinned {};
  packages = self: with self; [
    containers
    unordered-containers
  ];
}
