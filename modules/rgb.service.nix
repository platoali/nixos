{ pkgs, lib, ... }:
let
  color = "000000";
  no-rgb = pkgs.writers.writeBash  "no-rgb" ''
   
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i  --mode direct --color ${color} > /dev/null 
    done                          

  '';
  in {
    config = {
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
