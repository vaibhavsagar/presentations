#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/b828d00ffdae51ee44e04f2104d18eeee75344a0.tar.gz
#! nix-shell -i bash -p screenkey

screenkey -t 0.5
