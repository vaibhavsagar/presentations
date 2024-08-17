let
  pkgs    = import ../.nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  images  = nixpkgs.lib.sourceByRegex ./images [ ".*\.svg$" ".*\.png$" ];
  command = src: pkgs: ''
    mkdir -p $out
    pandoc \
      --standalone \
      --mathjax \
      -t revealjs \
      -V theme:solarized \
      ${src + "/presentation.md"} \
      -H ${src + "/header.html"} \
      -A ${../tracking.html} \
      -A ${src + "/reveal-configuration.html"} \
      -o $out/index.html
    ln -s ${images} $out/images
  '';
in
import ../.nix/default.nix { inherit command; name = "sat-solvers"; src = ./.; extraBuildInputs = pkgs: [ pkgs.graphviz ]; }
