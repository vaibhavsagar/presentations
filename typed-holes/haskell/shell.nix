let
  nixpkgs = import (import ../../.nix/pkgs.nix).nixpkgs {};
in nixpkgs.mkShell {
  buildInputs = [ (nixpkgs.haskell.packages.ghc822.ghcWithPackages (p: [ p.ghcid ])) ];
}
