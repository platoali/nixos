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
      settings = { 
        user.name = "Ali A. Yazdi" ;
        user.email = "platoali@gmail.com";
      };
    };

  };
}
  
