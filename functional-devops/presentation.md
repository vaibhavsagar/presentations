% Functional DevOps
% (in a dysfunctional world)
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

## Webserver

```nix
{ ... }: {
  imports = [ ../nix/service.nix ];
  services.blank-me-up.enable = true;
}
```
*ops/webserver.nix*

## Webserver

```bash
$ cd ops/
$ nix-instantiate --eval -E '(import <nixpkgs/nixos/lib/eval-config.nix> { modules = [./webserver.nix]; }).config.systemd.units."blank-me-up.service".unit.text' | jq -r
[Unit]
After=network.target
Description=Blank Me Up

[Service]
Environment="LOCALE_ARCHIVE=/nix/store/xhmzzbq06fbzhvjamnb1192iwqb4wl0i-glibc-locales-2.25-49/lib/locale/locale-archive"
Environment="PATH=/nix/store/r90xqqmd36fv3s53bf92s3vxhdnbwfn7-coreutils-8.28/bin:/nix/store/02xjvflg03d9wlzdw1ig54rgwa32jwxq-findutils-4.6.0/bin:/nix/store/wia9b594w2ghzhpcjdi9mnlf8j24nm3i-gnugrep-3.1/bin:/nix/store/j4rqdjgf0im2dv7gycg80hplnjrnawxx-gnused-4.4/bin:/nix/store/dq33ar4qk4fvxx5ji4fg99nw282f08ia-systemd-234/bin:/nix/store/r90xqqmd36fv3s53bf92s3vxhdnbwfn7-coreutils-8.28/sbin:/nix/store/02xjvflg03d9wlzdw1ig54rgwa32jwxq-findutils-4.6.0/sbin:/nix/store/wia9b594w2ghzhpcjdi9mnlf8j24nm3i-gnugrep-3.1/sbin:/nix/store/j4rqdjgf0im2dv7gycg80hplnjrnawxx-gnused-4.4/sbin:/nix/store/dq33ar4qk4fvxx5ji4fg99nw282f08ia-systemd-234/sbin"
Environment="TZDIR=/nix/store/1sa5cpnrbdab2463bzbi3xfl3hck3aqk-tzdata-2017c/share/zoneinfo"



ExecStart=/nix/store/n6ky98lzs0abl1sabc270004hjf7pvnq-blank-me-up-0.1.0.0/bin/blank-me-up
KillMode=process
Restart=always
```

## Deployment

```nix
{
  network.description = "Web server";

  webserver = import ./webserver.nix;
}
```
*ops/trivial.nix*

## Deployment

```nix
{
  webserver =
    { config, pkgs, ... }:
    { deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 1024; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
    };
}
```


# Requirements Change
