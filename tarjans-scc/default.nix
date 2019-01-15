let
  pkgs    = import ../.nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  demo = nixpkgs.lib.sourceByRegex ./demo [".*\.svg$"];
  command = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -o $out/index.html
    cp -R ${pkgs.revealjs} $out/reveal.js
    ln -s ${demo} $out/demo
  '';
in
import ../.nix/default.nix { inherit command; name = "tarjans-scc"; src = ./.; }
