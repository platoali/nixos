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
    services.dictd.enable = true;
    services.dictd.DBs = with pkgs.dictdDBs; [  wordnet ];
    home-manager.backupFileExtension = "backup" ;
    programs.hyprland.withUWSM  = true;
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
      xdg.configFile."mimeapps.list".force = true;
    # XXX: dg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland ];
      xdg.portal.config.common.default = "*";

      services.udiskie = {
        enable = true;
        settings = {
          # workaround for
          # https://github.com/nix-community/home-manager/issues/632
          program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.xfce.thunar}/bin/thunar";
          };
        };
      };
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
      

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
       "mprime" 
           ];
      home.stateVersion = "24.11";
      # nixpkgs.overlays  = [
      #   (self: super: {
      #     darktable = super.darktable.overrideAttrs(finalAttrs: prevAttrs : {
      #       stdenv = super.stdenvAdapters.addAttrsToDerivation {
      #       };
      #       buildInputs  =  lib.remove  super.libavif  prevAttrs.buildInputs ;
      #     });
      #   }
      #   )
      # ];
      home.packages = with pkgs; [
        #obs-studio
        krita 
        blender-hip
        #brave
        #scummvm
        #warzone2100
        firefox 
        blesh 
        helvum
        amdgpu_top
        gimp3-with-plugins 
        feh
        zathura
        scrot
        cabal-install
        stack
        haskellPackages.haskell-language-server
        haskellPackages.hasktags
        haskellPackages.safe
        haskellPackages.split
        haskellPackages.zlib
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
       zeroad
        zlib
        telegram-desktop
        s-tui
        stress
        mpv
        hyprcursor
        p7zip
        inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
        yazi
        hyprsunset
        nh
        btop
        tmux
        iotop
        mtr
        haskellPackages.parsec_3_1_18_0
        unzip
        zip
        piper
        ripgrep
        jcal
        hunspell
        hunspellDicts.fa-ir 
        hunspellDicts.en-us
        hyprland-per-window-layout
        hyprpolkitagent
       #darktable
        rawtherapee
        xfce.thunar
       # v2raya
       adwaita-icon-theme
        gtk3
      ];
    };
  };
  }
