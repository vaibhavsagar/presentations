let
  fetch   = (import <nixpkgs> {}).fetchFromGitHub;
  pinned  = fetch (builtins.fromJSON (builtins.readFile ../../.nix/versions.json)).nixpkgs;
  nixpkgs = import pinned {};
in nixpkgs.mkShell {
  buildInputs = with nixpkgs.idrisPackages; [
    (with-packages [ base contrib prelude ])
  ];
}
