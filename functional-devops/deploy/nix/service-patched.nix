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
