let
  pkgs    = import ../.nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  images = nixpkgs.lib.sourceByRegex ./images [ ".*\.svg$" ".*\.png$" ];
  command = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:solarized ${src + "/presentation.md"} -A ${../tracking.html} -o $out/index.html
    ln -s ${images} $out/images
  '';
in
import ../.nix/default.nix { inherit command; name = "partial-evaluation"; src = ./.; }