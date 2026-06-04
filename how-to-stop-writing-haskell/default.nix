let
  pkgs    = import ../.nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  images  = nixpkgs.lib.sourceByRegex ./images [ ".*\.svg$" ".*\.png$" ".*\.jpg$" ".*\.webp$" ];
  command = src: pkgs: ''
    mkdir -p $out
    pandoc \
      --standalone \
      -t revealjs \
      -V theme:solarized \
      ${src + "/presentation.md"} \
      -H ${src + "/revealjs-override.html"} \
      -A ${../tracking.html} \
      -o $out/index.html
    ln -s ${images} $out/images
  '';
in
import ../.nix/default.nix { inherit command; name = "how-to-stop-writing-haskell"; src = ./.; }
