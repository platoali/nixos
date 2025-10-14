{lib , pkgs , config  ,  ... } :
let
  cfg = config.hyprland-custom-module ;
in  {
  options.hyprland-custom-module  = {
    enable = lib.mkEnableOption "enbale hyprland custom config" ;
    sshuttleToggleScript = lib.mkOption {
      default = "${../../auxFiles/sshuttleToggle.sh}" ;
       description = "stcipt to toggle the sshuttle vpn service" ;
    };
    backGroundImage = lib.mkOption {
      default = "${../../auxFiles/IMG_20190501_170029.jpg}";
      description = "Image as a background Image";
    };
  } ;

  config  = lib.mkIf cfg.enable {

   wayland.windowManager.hyprland.systemd.enable = false;
   wayland.windowManager.hyprland.plugins = [
     pkgs.hyprlandPlugins.hyprscrolling
   ];
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.xwayland.enable = true;
    wayland.windowManager.hyprland.systemd.variables = ["--all"];
    xdg.portal.enable  = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland ];
    xdg.portal.config.common.default = "*";
    xdg.mimeApps  = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/about" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/unknown" = ["org.qutebrowser.qutebrowser.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/about" = ["org.qutebrowser.qutebrowser.desktop"];
        "x-scheme-handler/unknown" = ["org.qutebrowser.qutebrowser.desktop"];
      };
    };
    wayland.windowManager.hyprland.settings = {
      monitor=",preferred,auto,auto";
  #    env = "XCURSOR_SIZE,24";
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        #"HYPRCURSOR_THEME,Future-Cyan-Hyprcursor_Theme" 
        "HYPRCURSOR_SIZE,30"];

      input = {
        kb_layout = "us,ir";
        #     kb_variant =
        #kb_model =
        kb_options = "ctrl:nocaps,grp:alt_caps_toggle";
        follow_mouse = "0";
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.
      };

      general =  {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        #col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        #col.inactive_border = "rgba(595959aa)";
        #layout = "master";
        layout = "scrolling";
        allow_tearing = false;
      };

      plugin = {
        hyprscrolling = {
          column_width =  0.7;
          explicit_column_widths = "0.333, 0.5, 0.667, 1.0";
          fullscreen_on_one_column = false ;
          follow_focus = true;
        };
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 2;
        blur ={
          enabled = true;
          size = 3;
          passes = 1;
        };
      #  drop_shadow = "yes";
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        #   col.shadow = "rgba(1a1a1aee)";
      };
      dwindle  = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes" ;# master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
       # new_is_master = false;
      };

      gestures  = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        #workspace_swipe = "off";
      };
      animations  = {
        enabled = "yes";

# Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          " workspaces, 1, 6, default"];
      };
      misc  = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        disable_hyprland_logo = false;
        disable_splash_rendering = false ;
      };
# See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mainMod" = "SUPER";

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [
#        "$mainMod, SHIFT, layoutmsg, colresize +
        "$mainMod, Q, exec, wlogout"
        "$mainMod, C, killactive, "
#        " $mainMod, M, exit, "
        "$mainMod, E, exec, emacsclient -c "
        "$mainMod SHIFT, E, exec, ec"
        "$mainMod, B, exec , qutebrowser"
        "$mainMod, P , exec , mpc toggle "
        "$mainMod SHIFT, F, togglefloating,"
        "$mainMod, F, fullscreen"
        "$mainMod, R, exec, wofi --show run"
        "$mainMod, S, exec, ${cfg.sshuttleToggleScript}"
        "$mainMod, return, exec ,alacritty"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod, j ,layoutmsg, cyclenext"
        "$mainMod SHIFT , j ,layoutmsg, swapnext "
        "$mainMod , Tab, layoutmsg , cyclenext"
        "Alt , Tab , cyclenext"
        "$mainMod, l ,layoutmsg, cycleprev"
        "$mainMod SHIFT , l ,layoutmsg, swapprev"
        "$mainMod, k,layoutmsg, orientationcycle top left"
        #"$mainMod SHIFT , right , resizeactive, 10 0 "
        #"$mainMod SHIFT , left, resizeactive , -10 0"
        "$mainMod SHIFT , right, layoutmsg, colresize +conf"
        "$mainMod SHIFT , left , layoutmsg, colresize -conf"
        "$mainMod SHIFT , minus, layoutmsg, colresize -0.1"
        "$mainMod SHIFT , equal , layoutmsg, colresize +0.1"

        "$mainMod CTRL, right, layoutmsg, movewindowto r"
        "$mainMod CTRL, left ,layoutmsg, movewindowto l"
        "$mainMod CTRL, up, layoutmsg, movewindowto u"
        "$mainMod CTRL, down  ,layoutmsg, movewindowto d"

        "$mainMod SHIFT , up , resizeactive, 0 -10  "
        "$mainMod SHIFT , down , resizeactive ,0 10 "
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      ];

      bindm = [
        " $mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once=[
        "dbus-update-activation-environment --systemd --all"
        "waybar"
        "mako"
        "swaybg -m fill -i  ${cfg.backGroundImage }" 
        #exec-once = hyprpaper 0
        "wl-paste --type text --watch cliphist store "
        "wl-paste --type image --watch cliphist store "
        "swayidle -w timeout 600 'swaylock -f ' timeout 605 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'"
        "qutebrowser --nowindow"
        "hyprland-per-window-layout"
#        "hyprsunset -t 5000"
      ];
    };
  };
}
