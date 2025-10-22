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
      -V revealjs-url="https://unpkg.com/reveal.js@^4" \
      ${src + "/presentation.md"} \
      -H ${src + "/revealjs-override.html"} \
      -H ${src + "/mathjax-configuration.html"} \
      -A ${src + "/reveal-configuration.html"} \
      -A ${../tracking.html} \
      -o $out/index.html
    ln -s ${images} $out/images
  '';
in
import ../.nix/default.nix { inherit command; name = "sat-solvers"; src = ./.; extraBuildInputs = pkgs: [ pkgs.graphviz ]; }
