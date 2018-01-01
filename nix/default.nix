let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  pkgs = import versions.nixpkgs {};
in name: src: let input = src + "/presentation.md"; in pkgs.runCommand name {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple ${input} -o $out/index.html
  cp -R ${versions.revealjs} $out/reveal.js
''
