let
  fetch   = (import <nixpkgs> {}).fetchFromGitHub;
  pinned  = fetch (builtins.fromJSON (builtins.readFile ../../.nix/versions.json)).nixpkgs;
  nixpkgs = import pinned {};
  ext     = self: super: {
    ghcid = nixpkgs.haskell.lib.overrideSrc super.ghcid {
      src = fetch {
        owner  = "ndmitchell";
        repo   = "ghcid";
        rev    = "9773482fd83bf0bc528bbcb0ad121191a8fd809b";
        sha256 = "18wi0ghxl9kszivyf50aixpbq7srrdncawk7x1fzxhyimm89qqqq";
      };
    };
  };
in nixpkgs.mkShell {
  buildInputs = [ ((nixpkgs.haskell.packages.ghc822.extend ext).ghcWithPackages (p: [ p.ghcid ])) ];
}
