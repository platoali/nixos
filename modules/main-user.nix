{lib  , pkgs, config , inputs,   ... } :
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
     # home = "/home/platoali";
      extraGroups = [ "wheel" "plocate"  "libvirtd" ];
      shell = pkgs.bash;
    };
    home-manager.users.${cfg.userName} = {pkgs, ... }: {
      imports = [
        ./user-custom/bash-custom.nix
        ./user-custom/hyprland-custom.nix
        ./user-custom/zathura-custom.nix
        ./user-custom/emacs-custom.nix
        ./user-custom/waybar-custom.nix
        ./user-custom/git-custom.nix
      ];
      bash-custom.enable = true  ;
      hyprland-custom-module.enable  = true ;
      zathura-custom.enable = true ;
      emacs-custom.enable = true ;
      git-custom.enable = true;
      waybar-custom.enable  = true;
      programs.home-manager.enable = true;
      xdg.portal.enable  = true;
    # XXX: dg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland ];
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
      home.stateVersion = "24.05";
      home.packages = with pkgs; [
        firefox 
        blesh 
        helvum
        blender-hip
        amdgpu_top
        gimp
        feh
        zathura
        scrot
        cabal-install
        stack
        haskellPackages.haskell-language-server
        ghc
        alacritty
        swaylock
        swayidle 
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
        exercism
        bats
        wl-clipboard
        cliphist
        bc
        haskellPackages.hakyll
        cabal2nix
        zeroad
        zlib
        telegram-desktop
        s-tui
        stress
        mpv
        hyprcursor
        brave
        scummvm
        p7zip
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        hyprsunset
      ];
    };
  };
  }
