let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  # versions = lib.mapAttrs
  #   (_: fetchFromGitHub)
  #   (builtins.fromJSON (builtins.readFile ../../.nix/versions.json));
  # pkgs = import versions.nixpkgs {};
  pkgs = import (fetchFromGitHub {
    owner  = "NixOS";
    repo   = "nixpkgs";
    rev    = "b828d00ffdae51ee44e04f2104d18eeee75344a0";
    sha256 = "00vrrik1cn5n5901ahi943mj5n2gn9f7dfg2qywfrn3z0hy9r590";
  }) {};
in pkgs.runCommand "dummy" {
  buildInputs = lib.singleton (pkgs.haskell.packages.ghc822.ghcWithPackages (p: [ p.ghcid ]));
} ""
