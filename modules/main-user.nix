{lib  , pkgs, config ,  ... } :
let
  cfg = config.main-user ;
in {
  options.main-user = {
    enable = lib.mkEnableOption " enable user module" ;
    userName  = lib.mkOption {
      default = "mainuser";
      description = '' username '';                 
    };
  } ;
  config  = lib.mkIf cfg.enable  {
    users.users.${cfg.userName } = {
      isNormalUser = true;
      home = "/home/platoali";
      extraGroups = [ "wheel" "plocate"  ];
      shell = pkgs.bash;
      packages = with pkgs; [
        firefox 
        blesh 

        blender
        gimp
        feh
        zathura
        scrot
        cabal-install
        stack
        haskellPackages.haskell-language-server
        alacritty
        swaylock
        swaybg
        qutebrowser
        waybar
        wlogout
        wofi
        sshuttle
        git
        mpc-cli
        obs-studio
        krita 
        #emacs
        nomacs 
        wpaperd
        mpvpaper
        grim
        mako
        libnotify
      ];
    };
    home-manager.users.${cfg.userName} = {pkgs, ... }: {
   
      imports = [
        #        ./bash.nix
        ./user-custom/bash-custom.nix
        ./user-custom/hyprland-custom.nix
        ./user-custom/zathura-custom.nix
        ./user-custom/emacs-custom.nix
        ./user-custom/waybar-custom.nix
          #      ./sshuttle.service.nix
      ];
      bash-custom.enable = true  ;
      hyprland-custom-module.enable  = true ;
      zathura-custom.enable = true ;
      emacs-custom.enable = true ;
      # waybar-custom = true;
      waybar-custom.enable  = true;
      programs.home-manager.enable = true;

      home.stateVersion = "24.05";
    };
  };
}

  
 
