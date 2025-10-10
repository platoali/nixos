{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      # ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default 
      # ./modules/main-user.nix
      # ./modules/sshuttle.service.nix
      # ./modules/rgb.service.nix
      # ./modules/virt-manager.nix
      # ./modules/mpd_custom_service.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;
  
  networking.hostName = "nixos";

  # Set your time zone.
  time.timeZone = "Asia/Tehran";
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.extraHosts = ''
195.201.181.62 sahar
'';
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.hardware.openrgb.enable = true;
  services.ratbagd.enable = true;
  services.fwupd.enable = true;
   main-user.enable = true;
   main-user.userName = "platoali" ;

   sshuttle-service.enable = true;
   sshuttle-service.host = "sahar:4000";
   sshuttle-service.netrange = "0/0";
   sshuttle-service.user = "platoali" ;
   sshuttle-service.sshuttleConnectionOptions = " --dns -x 192.168.1.0/24 -x 127.0.0.1/8" ;

   open-rgb-service.enable = true;
   open-rgb-service.color = "010101";

   mpd_custom_service.enable  =  true ;

   virt-manager-custom.enable = true;
    # started in user sessions.
   programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
   # };
   security.polkit.enable = true;
   security.pam.services.swaylock = {};
    # xdg.mime.enable = true;
    # xdg.mime.defaultApplications = {
    #   "application/pdf" = "org.pwmt.zathura.desktop";
    #   "text/html" = "org.qutebrowser.qutebrowser.desktop";
    #   "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    #   "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
    #   "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
    #   "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    # };
    
    services.emacs = { 
      enable = true;
      defaultEditor = true;
      install = true ;
    };

#    services.dictd.enable = true;
  #  services.dictd.DBs = with pkgs.dictdDBs; [  wordnet ];
     networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
     services.resolved = {
       enable = true  ;
       dnssec = "true";
       domains = [ "~." ];
      fallbackDns = [ "4.2.2.4" "192.9.9.3" ];
    #  # dnsovertls = "true";
     };
    
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time" ;
        };
      };
    };


     programs.uwsm  = {
       enable = true;
       waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "${pkgs.hyprland}/bin/Hyprland";
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

    nix.gc =  {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;
    
  fonts.packages = with pkgs; [
    roboto 
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vazir-fonts
    nerd-fonts.symbols-only
    font-awesome_6
    jetbrains-mono
  ];
   nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
       "mprime"
           ];
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "mprime"
  #    # "steam"
  #     # "steam-original"
  # ];
   nixpkgs.config.allowUnfree = true;
    programs.dconf.enable = true;
   # environment.variables = rec {
   #   GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
   # }; 

   #  programs.steam  = {
   #      enable = true;
   # };
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 53317 ];
   networking.firewall.allowedUDPPorts = [53317 ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;

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
  nix.settings.cores = 24;
  nix.settings.download-attempts=20;
  nix.settings.http-connections=5;
  nix.settings.download-speed=150;
}

