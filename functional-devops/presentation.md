% Functional DevOps in a Dysfunctional World
% Vaibhav Sagar

# About Me

# Why DevOps?

## Works on my machine

## What happens after you write the last line of code?

# DevOps Desiderata

## Automatic

## Repeatable

## Idempotent

## Reversible

## Atomic

# A Tiny Web Service

## Blank Me Up

```haskell
 {-# LANGUAGE OverloadedStrings #-}

import Web.Scotty

import Data.Monoid (mconcat)

main = scotty 3000 $ do
    get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
```
*app/Main.hs*

## Blank Me Up

```cabal
name:                blank-me-up
version:             0.1.0.0
license:             BSD3
build-type:          Simple
cabal-version:       >=1.10

executable blank-me-up
  main-is:             Main.hs
  build-depends:       base >=4.9 && <5
                     , scotty
  default-language:    Haskell2010
```
*app/blank-me-up.cabal*

## Nix

```bash
$ mkdir nix
$ cd nix/
$ cabal2nix --shell ../app/ > default.nix
$ nix-build
<...>
$ nix-build
$ result/bin/blank-me-up
```

## Service

```nix
{ config, lib, pkgs, ... }:

let

in {
  options                             =                                 ;

  config =                      
                                                   

                                    
                                  
                                   
                                         
                       
                                                     
                           
                             
        
      
   ;
}
```
*nix/service.nix*

## Service

```nix
{ config, lib, pkgs, ... }:

let
  blank-me-up = pkgs.callPackage ./default.nix { nixpkgs = pkgs; };
in {
  options                             =                                 ;

  config =












   ;
}
```
*nix/service.nix*

## Service

```nix
{ config, lib, pkgs, ... }:

let
  blank-me-up = pkgs.callPackage ./default.nix { nixpkgs = pkgs; };
in {
  options.services.blank-me-up.enable = lib.mkEnableOption "Blank Me Up";

  config = lib.mkIf config.services.blank-me-up.enable {












  };
}
```
*nix/service.nix*

## Service

```nix
{ config, lib, pkgs, ... }:

let
  blank-me-up = pkgs.callPackage ./default.nix { nixpkgs = pkgs; };
in {
  options.services.blank-me-up.enable = lib.mkEnableOption "Blank Me Up";

  config = lib.mkIf config.services.blank-me-up.enable {
    networking.firewall.allowedTCPPorts = [ 3000 ];

    systemd.services.blank-me-up = {
      description = "Blank Me Up";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${blank-me-up}/bin/blank-me-up";
        Restart = "always";
        KillMode = "process";
      };
    };
  };
}
```
*nix/service.nix*

# Shipping It

# Requirements Change
