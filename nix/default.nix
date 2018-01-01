let
  inherit (import <nixpkgs> {}) fetchFromGitHub lib;
  versions = lib.mapAttrs
    (_: fetchFromGitHub)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  pkgs = import versions.nixpkgs {};
in name: src: pkgs.runCommand name {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -o $out/index.html
  cp -R ${versions.revealjs} $out/reveal.js
''
