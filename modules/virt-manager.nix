{pkgs, lib, config,   ... } :
let
  cfg = config.virt-manager-custom ;
in
{
  options.virt-manager-custom =  {
    enable = lib.mkEnableOption " enable virtualazation custom" ;
   
  };
  config = lib.mkIf cfg.virt-manager-custom.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

  };
}
  
