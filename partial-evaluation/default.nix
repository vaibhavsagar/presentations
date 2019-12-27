let
  pkgs    = import ../.nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  command = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:solarized ${src + "/presentation.md"} -A ${../tracking.html} -o $out/index.html
    cp -R ${pkgs.revealjs} $out/reveal.js
  '';
in
import ../.nix/default.nix { inherit command; name = "partial-evaluation"; src = ./.; }
