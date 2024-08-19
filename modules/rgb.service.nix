{ pkgs, config, lib, ... }:
let

  no-rgb = pkgs.writers.writeBash  "no-rgb" ''
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)
    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i  --mode direct --color ${cfg.color} > /dev/null
    done                          
  '';
  cfg = config.open-rgb-service ;
in {
  options.open-rgb-service  = {
    enable  =  lib.mkEnableOption " enable openrgb service" ;
    color = lib.mkOption  {
      default  = "010101" ;
      description = " default color for leds" ;
    };
      rgb-script  = lib.mkOption  {
        default  = no-rgb;
        description = "script that run LED coloring";
      };
  };
    config =  lib.mkIf cfg.enable  {
      services.udev.packages = [ pkgs.openrgb ];
      boot.kernelModules = [ "i2c-dev" ];
      hardware.i2c.enable = true;

      systemd.services.no-rgb = {
        enable = true;
        description = "no-rgb";
        serviceConfig = {
          ExecStart = "${no-rgb}";
          Type = "oneshot";
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  }
