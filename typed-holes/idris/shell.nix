let
  nixpkgs = import (import ../../.nix/pkgs.nix).nixpkgs {};
in nixpkgs.mkShell {
  buildInputs = with nixpkgs.idrisPackages; [
    (with-packages [ base contrib prelude ])
  ];
}
