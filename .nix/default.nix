let
  inherit (import <nixpkgs> {}) lib;
  fetcher = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  versions = lib.mapAttrs
    (_: fetcher)
    (builtins.fromJSON (builtins.readFile ./versions.json));
  pkgs = import versions.nixpkgs {};
in name: src: pkgs.runCommand name {
  buildInputs = [
    pkgs.haskellPackages.pandoc
    pkgs.python3
  ];
} ''
  mkdir -p $out
  pandoc --standalone -t revealjs -V theme:simple ${src + "/presentation.md"} -o $out/index.html
  cp -R ${versions.revealjs} $out/reveal.js
''
