{pkgs, config , lib , ... } :
let
  cfg= config.mpd_custom_service ;
in  { 
    options.mpd_custom_service = {
         enable = lib.mkEnableOption "enable mpd_custom_service";
       };
  config = lib.mkIf cfg.enable  {
    services.mpd = {
      enable = true;
      user = "platoali" ;
      musicDirectory = "/home/platoali/Music";
      playlistDirectory = "/home/platoali/Music/playListDirectoy" ;
      dbFile = "/home/platoali/playListDirectoy/dbFile";
      extraConfig = ''
        audio_output {
         type "pipewire"
         name "Pipewire server"
         enabled "yes"
        }
       db_file             "/home/platoali/Music/mpd/tag_cache"  

       state_file          "/home/platoali/Music/mpd/state"
       sticker_file        "/home/platoali/Music/mpd/sticker.sql"
       '';
      startWhenNeeded = true ;
    };
    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
  };
}
