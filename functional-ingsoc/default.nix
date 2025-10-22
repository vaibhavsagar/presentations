let command = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:solarized -V revealjs-url="https://unpkg.com/reveal.js@^4" ${src + "/presentation.md"} -A ${../tracking.html} -o $out/index.html
  '';
in
import ../.nix/default.nix { inherit command; name = "functional-ingsoc"; src = ./.; }
