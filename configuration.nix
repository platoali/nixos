{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default 
      ./modules/main-user.nix
      ./modules/sshuttle.service.nix
      ./modules/rgb.service.nix
      ./modules/virt-manager.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

 networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below nnietworking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  networking.extraHosts = ''
136.243.240.66 sahar
'';
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    tmux
    wget
    htop
    mtr
    iotop
  ];
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.hardware.openrgb.enable = true;
  services.ratbagd.enable = true;

   main-user.enable = true;
   main-user.userName = "platoali" ;

   sshuttle-service.enable = true;
   sshuttle-service.host = "sahar:14000";
   sshuttle-service.netrange = "0/0";
   sshuttle-service.user = "platoali" ;

   open-rgb-service.enable = true;
   open-rgb-service.color = "000000";

   virt-manager-custom.enable = true;
    # started in user sessions.
   programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
   security.pam.services.swaylock = {};
    programs.hyprland = { 
             enable=true;
            xwayland.enable=true;
    };

    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
    
    xdg.portal.enable  = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland ];


    services.emacs = { 
      enable = true;
      defaultEditor = true;
      install = true ;
    };


    services.dictd.enable = true;
#    networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

   services.resolved = {
      enable = false ;
      dnssec = "true";
      domains = [ "~." ];
  #    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
    
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland" ;
        };
      };
    };

#    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    
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
    
  fonts.packages = with pkgs; [
    roboto 
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vazir-fonts
    #  nerdfonts
    awesome
    font-awesome_4
    font-awesome_5
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes"]; 
}

