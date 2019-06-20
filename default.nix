let
  inherit (import <nixpkgs> {}) linkFarm;
  presentations = map (folder: {
    name = folder;
    path = import (./. + "/${folder}");
  });
in linkFarm "presentations" (presentations [
  "functional-devops"
  "functional-ingsoc"
  "javascript-in-haskell"
  "lazy-functional-state-threads"
  "popcount"
  "tarjans-scc"
  "typed-holes"
])
