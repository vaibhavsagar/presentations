let
  pkgs    = import .nix/pkgs.nix;
  nixpkgs = import pkgs.nixpkgs {};
  presentation = folder: {
    name = folder;
    path = import (./. + "/${folder}");
  };
  folders = [
    "functional-devops"
    "functional-ingsoc"
    "how-to-stop-writing-haskell"
    "ihaskell-can-do-that"
    "javascript-in-haskell"
    "lazy-functional-state-threads"
    "minimal-perfect-hashing"
    "partial-evaluation"
    "popcount"
    "sat-solvers"
    "space-efficient-static-trees-graphs"
    "tarjans-scc"
    "typed-holes"
  ];
  index = names: let
    entry = folder: ''<li><a href="./${folder}/">${folder}</li>'';
    header = ''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>Presentations</title>
      </head>
    '';
    body = nixpkgs.lib.strings.concatLines ([
      "<body>"
      "<h1>Presentations</h1>"
      "<ul>"
    ] ++ (map entry names) ++ [
      "</ul>"
      "</body>"
    ]);
    footer = "</html>";
  in nixpkgs.writeText "index.html" (nixpkgs.lib.strings.concatStrings [
    header
    body
    footer
  ]);
in nixpkgs.symlinkJoin {
  name = "presentations";
  paths = [
    (nixpkgs.linkFarm "presentations" (map presentation folders))
  ];
  postBuild = ''
    ln -s ${index folders} $out/index.html
  '';
}
