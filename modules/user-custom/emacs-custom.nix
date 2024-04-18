{lib , pkgs , config  ,  ... } :
let
  cfg = config.emacs-custom;
in  {
  options.emacs-custom = {
    enable = lib.mkEnableOption "enbale zathura custom config" ;
  } ;

  config  = lib.mkIf cfg.enable { 


#  services.emacs.enable = true;
#  services.emacs.client.enable = true;
  services.emacs = {
    enable  = true ;
    startWithUserSession = true;
    socketActivation.enable = false ;

    client = {
      enable = true;
    };
  };
 
  };
}
