let
  pkgs    = import ./pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
in name: src: nixpkgs.runCommand name {
  buildInputs = [
    nixpkgs.haskellPackages.pandoc
    nixpkgs.python3
  ];
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -o $out/index.html
  cp -R ${pkgs.revealjs} $out/reveal.js
''
