let
  pkgs    = import ./pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  defaultCommand = src: pkgs: ''
    mkdir -p $out
    pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -A ${../tracking.html} -o $out/index.html
  '';
in { command ? defaultCommand, name, src, extraBuildInputs ? (_: []) }: nixpkgs.runCommand name {
  buildInputs = [
    nixpkgs.entr
    nixpkgs.pandoc
    nixpkgs.haskellPackages.wai-app-static
  ] ++ (extraBuildInputs nixpkgs);
} (command src pkgs)
