let command = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:solarized ${src + "/presentation.md"} -o $out/index.html
    cp -R ${pkgs.revealjs} $out/reveal.js
  '';
in
import ../.nix/default.nix { inherit command; name = "functional-ingsoc"; src = ./.; }
