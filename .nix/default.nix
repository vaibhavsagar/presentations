let
  pkgs    = import ./pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  defaultCommand = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -o $out/index.html
    cp -R ${pkgs.revealjs} $out/reveal.js
  '';
in { command ? defaultCommand, name, src }: nixpkgs.runCommand name {
  buildInputs = [
    nixpkgs.haskellPackages.pandoc
    nixpkgs.haskellPackages.wai-app-static
  ];
} (command src pkgs)
