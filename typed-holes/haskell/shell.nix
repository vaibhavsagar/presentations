let
  overlay = self: super: {
    haskellPackages = super.haskellPackages.extend ( self_: super_: {
      extra = self_.callHackage "extra" "1.6.6" {};
      ghcid = self_.callHackage "ghcid" "0.7" {};
    });
  };
  nixpkgs = import (import ../../.nix/pkgs.nix).nixpkgs { overlays = [ overlay ]; };
in nixpkgs.mkShell {
  buildInputs = [ (nixpkgs.haskellPackages.ghcWithPackages (p: [ p.ghcid ])) ];
}
