let
  fetcher = { owner, repo, rev, sha256 }: builtins.fetchTarball {
    inherit sha256;
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  };
  pinned  = fetcher (builtins.fromJSON (builtins.readFile ../../.nix/versions.json)).nixpkgs;
  nixpkgs = import pinned {};
in nixpkgs.mkShell {
  buildInputs = with nixpkgs.idrisPackages; [
    (with-packages [ base contrib prelude ])
  ];
}
