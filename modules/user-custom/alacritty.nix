{lib , pkgs , config  ,  ... } :
let
  cfg = config.alacritty-custom;
in  {
  options.alacritty-custom = {
    enable = lib.mkEnableOption "enable alacritty custom config";
    font_family = lib.mkOption {
      default = "JetBrains Mono";
      description = "default font family";
      
    };
    font-size = lib.mkOption {
      default = 13 ;
      description = "default font size";
    };
        
  }; 
  config  = lib.mkIf cfg.enable { 
    programs.alacritty = {
      enable = true;
      settings = {
        font = { 
          normal = { 
            family =  "${cfg.font_family}";
            style= "Normal";
          };
          bold = {
            family= "${cfg.font_family}";
            style=  "Bold";
          };
          italic = {
            family= "${cfg.font_family}";
            style= "Italic";
          };
          bold_italic = {
            family = "${cfg.font_family}";
            style=  "Bold Italic";
          };
          size = cfg.font-size;
        };
      };
    };
  };
}
