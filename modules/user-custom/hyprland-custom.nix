{lib , pkgs , config  ,  ... } :
let
  cfg = config.hyprland-custom-module ;
in  {
  options.hyprland-custom-module  = {
    enable = lib.mkEnableOption "enbale hyprland custom config" ;
  } ;

  config  = lib.mkIf cfg.enable { 
      wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.xwayland.enable = true;

    wayland.windowManager.hyprland.settings = {
      monitor=",preferred,auto,auto";
      env = "XCURSOR_SIZE,24";
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
        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 2;
        blur ={
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        #   col.shadow = "rgba(1a1a1aee)";
      };


      dwindle  = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes" ;# master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = false ;
      };

      gestures  = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };

    };
    wayland.windowManager.hyprland.extraConfig = ''

animations {
enabled = yes

# Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

bezier = myBezier, 0.05, 0.9, 0.1, 1.05

animation = windows, 1, 7, myBezier
animation = windowsOut, 1, 7, default, popin 80%
animation = border, 1, 10, default
animation = borderangle, 1, 8, default
animation = fade, 1, 7, default
animation = workspaces, 1, 6, default
}

misc {
# See https://wiki.hyprland.org/Configuring/Variables/ for more
force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
disable_hyprland_logo = false
disable_splash_rendering = false 
}


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Q, exec, wlogout
bind = $mainMod, C, killactive, 
bind = $mainMod, M, exit, 

bind = $mainMod, E, exec, emacsclient -c 
bind = $mainMod SHIFT, E, exec, ec
bind = $mainMod, B, exec , qutebrowser
bind = $mainMod, P , exec , mpc toggle 
bind = $mainMod SHIFT, F, togglefloating,
bind = $mainMod, F, fullscreen
bind = $mainMod, R, exec, wofi --show run
bind = $mainMod, S, exec, ~/bin/sshuttle.service.toggle.sh
#bind = $mainMod, P, pseudo, # dwindle
#bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, return, exec ,alacritty -o font.size=12
# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d


# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10



# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10


bind = $mainMod, j ,layoutmsg, cyclenext
bind = $mainMod SHIFT , j ,layoutmsg, swapnext 
bind = $mainMod , Tab, layoutmsg , cyclenext
bind = Alt , Tab , cyclenext
bind = $mainMod, l ,layoutmsg, cycleprev
bind = $mainMod SHIFT , l ,layoutmsg, swapprev

bind = $mainMod, k,layoutmsg, orientationcycle top left

bind = $mainMod SHIFT , right , resizeactive, 10 0 
bind = $mainMod SHIFT , left, resizeactive , -10 0

bind = $mainMod SHIFT , up , resizeactive, 0 -10  
bind = $mainMod SHIFT , down , resizeactive ,0 10 


#bind = $mainMod, k, orientationleft
#bind = $mainMod, l, orientationtop
# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1


# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

exec-once=waybar
exec-once=mako 
exec-once = swaybg -m fill -i /home/platoali/Photos/IMG_20190501_170029.jpg
#exec-once = hyprpaper 
exec-once = wl-paste --type text --watch cliphist store #Stores only text data
exec-once = wl-paste --type image --watch cliphist store #Stores only image data
exec-once=swayidle -w timeout 600 'swaylock -f ' timeout 605 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'
exec-once=qutebrowser --nowindow
exec-once=hyprland-per-window-layout 
bind = $mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy
'';
  };
}
