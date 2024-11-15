{lib , pkgs , config  ,  ... } :
let
  cfg = config.emacs-custom;
in  {
  options.emacs-custom = {
    enable = lib.mkEnableOption "enbale emace server custom config" ;
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
  # xdg.desktopEntries.emacsclient = {
  #   name="Emacs Client";
  #   exec="emacsclient 
  #   mimeType = [ "text/english" " text/plain" "text/x-makefile" " text/x-c++hdr" " text/x-c++src" " text/x-chdr" " text/x-csrc" " text/x-java" " text/x-moc" "text/x-pascal" "text/x-tcl" " text/x-tex" " application/x-shellscript" " text/x-c;text/x-c++" ];
  # };
  };
}
