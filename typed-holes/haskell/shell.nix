let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ../../.nix/versions.json));
  pkgs = import versions.nixpkgs {};
in pkgs.runCommand "dummy" {
  buildInputs = lib.singleton (pkgs.haskell.packages.ghc822.ghcWithPackages (p: [ p.ghcid ]));
} ""
