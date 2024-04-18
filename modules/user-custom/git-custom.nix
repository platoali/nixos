{lib , pkgs , config  ,  ... } :
let
  cfg = config.git-custom ;
in  {
  options.git-custom  = {
    enable = lib.mkEnableOption "enbale git  custom config" ;
  } ;

  config  = lib.mkIf cfg.enable {
    programs.git = {
      enable = true ;
      userName = "Ali A. Yazdi" ;
      userEmail = "platoali@gmail.com";
    };

  };
}
  
