let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "functional-devops" {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
  src = ./.;
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple $src/presentation.md -o $out/index.html
  cp -R $src/reveal.js $out/
''
