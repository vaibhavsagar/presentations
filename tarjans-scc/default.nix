let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  pkgs = import versions.nixpkgs {};
in pkgs.runCommand "tarjans-scc" {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
  src = ./.;
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple $src/presentation.md -o $out/index.html
  cp -R ${versions.revealjs} $out/reveal.js
''
