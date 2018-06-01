let
  pkgs     = import ../.nix/pkgs.nix;
  IHaskell = pkgs.ihaskell;
  pinned   = pkgs.nixpkgs;
in import "${IHaskell}/release.nix" {
  compiler = "ghc822";
  nixpkgs = import pinned {};
  packages = self: with self; [
    containers
    unordered-containers
    vector
  ];
}
