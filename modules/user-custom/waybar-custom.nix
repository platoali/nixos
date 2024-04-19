{lib , pkgs , config  ,  ... } :
let
  cfg = config.waybar-custom;
  sshuttle-toggle = pkgs.writeScript  "sshuttle-toggle " ''

#!/usr/bin/env -S bash 

if [[ $(systemctl --user status sshuttle.service | grep Activ | awk ' {print $2}') = "active" ]]
then
    systemctl --user stop sshuttle.service
else
    systemctl --user start sshuttle.service
fi
'' ;
in  {
  options.waybar-custom = {
    enable = lib.mkEnableOption "enbale waybar  custom config" ;
  } ;

  config  = lib.mkIf cfg.enable { 
    programs.waybar =  {
      enable = true;
      settings = {
        mainBar  = { 
          layer = "top";
          height = 4;
          modules-left = ["hyprland/workspaces"];
          modules-right =  ["mpd" "custom/keyboard_layout"   "wireplumber" "custom/sshuttle"  "network"  "cpu"  "memory"  "temperature"  "custom/jalali"  "clock"];

          "hyprland/workspaces"  = {
            format = "<sub>{icon}</sub>\n";
            format-window-separator = "\n";
            window-rewrite-default = "";
            window-rewrite =  {
              "title<.*youtube.*>" =  ""; 
                "class<firefox>" = "" ; 
                "class<firefox> title<.*github.*>" =  "";
	          };
          };

          "mpd" =  {
            "format" =  "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S})  {volume}% ";
            "format-disconnected" = "Disconnected ";
            "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            "unknown-tag" = "N/A";
            "interval" = 2;
            "consume-icons" =  {
              "on" = " ";
            };
            "random-icons" = {
              "off" = "<span color=\"#f53c3c\"></span> ";
              "on" = " ";
            };
            "repeat-icons" =  {
            "on" = " ";
            };
            "single-icons" = {
              "on" = "1 ";
            };
            "state-icons" = {
              "paused" = "" ;
              "playing" = "";
            };
            "tooltip-format" = "MPD (connected)";
            "tooltip-format-disconnected" = "MPD (disconnected)";
	          "on-click-middle" = "mpc toggle";
	          "on-click" = "mpc prev";
	          "on-click-right"=  "mpc  nex";
	          "on-scroll-up" = "mpc volume +2";
	          "on-scroll-down" = "mpc volume -2";
          };
          "idle_inhibitor" =  {
            "format" = "{icon}";
            "format-icons" = {
              "activated" = "";
              "deactivated" = "";
            };
          } ;

          "wireplumber" = {
    		    "format" = "{volume}% {icon}";
   		     "format-muted" ="";
   		      "on-click" ="helvum";
    		    "format-icons" = [""  "" ""];
		        "max-volume" = "90.0";
          };
          
          "custom/sshuttle"  = {
            "format" = "{}";
            "exec" = " systemctl --user status sshuttle.service | grep Activ | awk '{if ($2 == \"active\") {print \"\"} else {print \"x\"}}'" ;
            "interval"  = 2;
            "on-click"  =  "${sshuttle-toggle}";
          };
          
          "network" =  {
            #        // "interface": "wlp2*", // (Optional) To force the use of this interface
            #    //   "format-wifi": "{essid} ({signalStrength}%) ",
            #  //    "format-ethernet": "{ipaddr}/{cidr} ",
            "format-ethernet" = "{bandwidthDownBytes} / {bandwidthUpBytes} ";
            #//        "format-ethernet": "{bandwidthDownBytes} / {bandwidthUpBytes} &#xf796; ",
            "tooltip-format" = "{ifname} via {gwaddr} ";
            "format-linked" = "{ifname} (No IP) ";
            "format-disconnected" = "Disconnected ⚠";
            "format-alt" = "{ifname}: {ipaddr}/{cidr}";
          };

          "cpu" = {
            "format" = "{usage}% ";
            "tooltip" = false;
          };
          
          "memory" = {
            "format" = "{}% ";
          };
          
          "temperature" = {
            #// "thermal-zone": 2,
            # // "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
            #// 	"hwmon-path-abs": "/sys/devices/platform/coretemp.0/hwmon",
	          "hwmon-path" = "/sys/class/hwmon/hwmon3/temp1_input";
            #            //        "input-filename": "temp1_input",
            "critical-threshold" = 80;
            #        // "format-critical": "{temperatureC}°C {icon}",
            "format" = "{temperatureC}°C {icon}";
            "format-icons" = [""  ""  ""];
          };

          "custom/jalali" = {
            "format" = "{}";
            "exec" = "$HOME/bin/jalalicli today";
            "interval"  = 3600;
          };

          "clock" =  {
            "format" = "{:%Y-%m-%d %H:%M}";            
            "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            "format-alt" =  "{:%H-%M}";
          };
        };
      };
   
      style = ''
* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 10px;
    padding:0;
    margin : 0;
    min-height : 0;
}

window#waybar {
    background-color: rgba(43, 48, 59, 0.5);
    border-bottom: 2px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button {
    padding: 0 1px;
    background-color: transparent;
    color: #ffffff;
    
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

/* #workspaces button.focused { */
/*     background-color: #64727D; */
/*     box-shadow: inset 0 -3px #ffffff; */
/* } */

#workspaces button.active {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}



#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    border-bottom: 1px solid #fffff0;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#custom-sshutle 
#mpd {
    padding: 0 2px;
    color: #ffffff;
}

#window,
#workspaces {
    margin: 0 0px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #64727D;
}

#battery {
    background-color: #ffffff;
    color: #000000;
}

#battery.charging, #battery.plugged {
    color: #ffffff;
    background-color: #26A65B;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #2ecc71;
    color: #000000;
}

#memory {
    background-color: #9b59b6;
}

#disk {
    background-color: #964B00;
}

#backlight {
    background-color: #90b1b1;
}

#network {
    background-color: #2980b9;
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: #f1c40f;
    color: #000000;
}

#pulseaudio.muted {
    background-color: #90b1b1;
    color: #2a5c45;
}

#wireplumber {
    background-color: #fff0f5;
    color: #000000;
}

#wireplumber.muted {
    background-color: #f53c3c;
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    background-color: #f0932b;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#tray {
    background-color: #2980b9;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #eb4d4b;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #00b093;
    color: #740864;
    padding: 0 5px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state {
    background: #97e1ad;
    color: #000000;
    padding: 0 0px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state > label {
    padding: 0 5px;
}

#keyboard-state > label.locked {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
	background-color: transparent;
}

#custom-sshuttle {
    background-color : pink  ;
    color: white ;
    padding:  0px 3px;
}

#custom-jalali {
    background-color: #3ebc91;
    color: white ;
}

#custom-keyboard_layout {
    background-color: turquoise;
}

tooltip {
  background: rgb(43, 48, 5);
  border: 1px solid rgba(100, 114, 125, 0.5);
 
}
tooltip label {
    color: white;
    font-size: 15px;
    
}




'' ;
    };
  };
}
