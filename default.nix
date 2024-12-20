let
  pkgs    = import .nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  presentations = map (folder: {
    name = folder;
    path = import (./. + "/${folder}");
  });
in nixpkgs.linkFarm "presentations" (presentations [
  "functional-devops"
  "functional-ingsoc"
  "ihaskell-can-do-that"
  "javascript-in-haskell"
  "lazy-functional-state-threads"
  "minimal-perfect-hashing"
  "partial-evaluation"
  "popcount"
  "sat-solvers"
  "space-efficient-static-trees-graphs"
  "tarjans-scc"
  "typed-holes"
])
