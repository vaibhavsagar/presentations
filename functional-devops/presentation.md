% Functional DevOps
% (in a dysfunctional world)
% Vaibhav Sagar (@vbhvsgr)

# Why DevOps?

## Works on my machine

## ~~Works on my machine~~

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

## Functional?

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
  network.enableRollback = true;

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
      deployment.virtualbox.headless = true; # don't show a display
      deployment.virtualbox.memorySize = 1024; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
      nixpkgs.system = "x86_64-linux";
    };
}
```
*ops/trivial-vbox.nix*

## Deployment

```bash
$ cd ops
$ nixops create trivial.nix trivial-vbox.nix -d trivial
$ nixops deploy -d trivial
<tons of output...>
$ nixops deploy -d trivial
$ curl <ip>:3000/help
```

## Functional?

# Requirements Change

## Patched

```nix
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
```
*nix/patched.nix*

## Service

```nix
{ config, lib, pkgs, ... }:

let
  blank-me-up = pkgs.callPackage ./patched.nix { nixpkgs = pkgs; };
  cfg = config.services.blank-me-up;
in {
  options.services.blank-me-up.enable = lib.mkEnableOption "Blank Me Up";
  options.services.blank-me-up.port = lib.mkOption {
    default = 3000;
    type = lib.types.int;
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ cfg.port ];

    systemd.services.blank-me-up = {
      description = "Blank Me Up";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${blank-me-up}/bin/blank-me-up ${toString cfg.port}";
        Restart = "always";
        KillMode = "process";
      };
    };
  };
}
```
*nix/service-patched.nix*

## Webserver

```nix
{ ... }: {
  imports = [ ../nix/service-patched.nix ];
  services.blank-me-up.enable = true;
  services.blank-me-up.port = 3001;
}
```
*nix/webserver.nix*

## Deploy

```bash
$ nixops deploy -d trivial
$ curl <ip>:3001/pull
```

## Rollback

```bash
$ nixops rollback -d trivial 1
```

# Summary

## Nix

- Package manager
- Programming language
- Build/environment tool

## NixOS

- Operating system built around Nix

## NixOps

- Cloud deployment tool on top of NixOS

## DevOps with Nix

- Automatic
- Repeatable
- Idempotent
- Reversible
- Atomic
- Functional!

# Thank You

# Questions?

## Suggestions

- Why would you use this instead of Docker?
- Make a change to your slides with Nix!
- Make a change to your website with Nix!
- How well does this work for multi-language projects?
