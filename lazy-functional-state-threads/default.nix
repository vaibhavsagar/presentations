let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  pkgs = import versions.nixpkgs {};
in pkgs.runCommand "lazy-functional-state-threads" {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple ${./presentation.md} -o $out/index.html
  cp -R ${versions.revealjs} $out/reveal.js
''
