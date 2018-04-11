let
  fetcher = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  nixpkgs = import (import ../../.nix/pkgs.nix).nixpkgs {};
  ext     = self: super: {
    ghcid = nixpkgs.haskell.lib.overrideSrc super.ghcid {
      src = fetcher {
        owner  = "ndmitchell";
        repo   = "ghcid";
        rev    = "8b8f71f8f31d497dc472f0de08db62290802775a";
        sha256 = "093i2j3rwk5bjlazylsjzaf0ig7r2sv2xnz439qymmfp6g412qkh";
      };
    };
  };
in nixpkgs.mkShell {
  buildInputs = [
    ((nixpkgs.haskell.packages.ghc822.extend ext).ghcWithPackages (p: [
        p.ghcid
    ]))
  ];
}
