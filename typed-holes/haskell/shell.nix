let
  overlay = self: super: {
    all-cabal-hashes = self.fetchurl {
      url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/61de1110af16fa0645a8cc8bbaf4a9c6fca9d8e8.tar.gz";
      sha256 = "0vwfm1imwcffyliaama572ksjgqmwxk48py0wgvgpi2vg08w7a12";
    };

    haskellPackages = super.haskellPackages.extend ( self_: super_: {
      extra = self_.callHackage "extra" "1.6.6" {};
      ghcid = self_.callHackage "ghcid" "0.7" {};
    });
  };
  nixpkgs = import (import ../../.nix/pkgs.nix).nixpkgs { overlays = [ overlay ]; };
in nixpkgs.mkShell {
  buildInputs = [ (nixpkgs.haskellPackages.ghcWithPackages (p: [ p.ghcid ])) ];
}
