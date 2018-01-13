args@{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

(import ./default.nix args).overrideAttrs (old: {
  postPatch = let
    oldImport = ''
      import Web.Scotty
    '';
    newImport = ''
      import Web.Scotty
      import System.Environment (getArgs)
    '';
    oldMain = ''
      main = scotty 3000 $ do
    '';
    newMain = ''
      main = getArgs >>= \(port:_) -> scotty (read port) $ do
    '';
  in ''
    substituteInPlace Main.hs --replace '${oldImport}' '${newImport}'
    substituteInPlace Main.hs --replace '${oldMain}'   '${newMain}'
    cat Main.hs
  '';
})
