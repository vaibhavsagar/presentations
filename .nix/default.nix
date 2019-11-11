let
  pkgs    = import ./pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  defaultCommand = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -A ${../tracking.html} -o $out/index.html
    cp -R ${pkgs.revealjs} $out/reveal.js
  '';
in { command ? defaultCommand, name, src }: nixpkgs.runCommand name {
  buildInputs = with nixpkgs.haskellPackages; [
    pandoc
    wai-app-static
  ];
} (command src pkgs)
