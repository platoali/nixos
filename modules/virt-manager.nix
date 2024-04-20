{pkgs, lib, config,   ... } :
let
  cfg = config.virt-manager-custom ;
in
{
  options.virt-manager-custom =  {
    enable = lib.mkEnableOption " enable virtualasation custom" ;
  };
  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}

  
