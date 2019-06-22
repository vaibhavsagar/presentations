let
  pkgs = {
    ihaskell = builtins.fetchTarball {
      url = "https://github.com/gibiansky/IHaskell/archive/146659e040c5cae70a303a1016aa305f5be2a293.tar.gz";
      sha256 = "1f4igqr2av9bgdbv2vqigkkw0ndc37zbzi6dgx66wnyyi8na5vy4";
    };
    nixpkgs = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs-channels/49dc8087a20e0d742d38be5f13333a03d171006a.tar.gz";
      sha256 = "1fdnqm4vyj50jb2ydcc0nldxwn6wm7qakxfhmpf72pz2y2ld55i6";
    };
  };
  overlay = sel: sup: {
    haskell = sup.haskell // {
      packages = sup.haskell.packages // {
        ghc844 = sup.haskell.packages.ghc844.override {
          overrides = self: super: {
            system-fileio = sel.haskell.lib.doJailbreak super.system-fileio;
            Chart = sel.haskell.lib.doJailbreak super.Chart;
            Chart-cairo = sel.haskell.lib.doJailbreak super.Chart-cairo;
          };
        };
      };
    };
  };
in import "${pkgs.ihaskell}/release.nix" {
  nixpkgs = import pkgs.nixpkgs { config.allowBroken = true; overlays = [ overlay ]; };
  compiler = "ghc844";
  packages = self: with self; [ ihaskell-diagrams ];
}
