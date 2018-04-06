let
  fetch   = (import <nixpkgs> {}).fetchFromGitHub;
  pinned  = fetch (builtins.fromJSON (builtins.readFile ../../.nix/versions.json)).nixpkgs;
  nixpkgs = import pinned {};
in nixpkgs.mkShell {
  buildInputs = [ (nixpkgs.haskell.packages.ghc822.ghcWithPackages (p: [ p.ghcid ])) ];
}
