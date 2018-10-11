let
  inherit (import <nixpkgs> {}) linkFarm;
  presentations = map (folder: {
    name = folder;
    path = import (./. + "/${folder}");
  });
in linkFarm "presentations" (presentations [
  "functional-devops"
  "functional-ingsoc"
  "lazy-functional-state-threads"
  "tarjans-scc"
  "typed-holes"
])
