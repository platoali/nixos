{lib , pkgs , config , ... } :
let
	cfg = config.ssh-custom;
in {
  options.ssh-custom = {
    enable = lib.mkEnableOption "enable ssh custom config ";
    identity_file = lib.mkOption {
      default = "~/.ssh/id_ed25519-github";
      description = "identity key file host" ;
    };

    host = lib.mkOption {
      default = "github.com";
      description = "hostname";
    };
  };
  config = lib.mkIf cfg.enable { 
    programs.ssh = {
      enable = true ;
      enableDefaultConfig= false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
      extraConfig = ''
Host ${cfg.host}
    AddKeysToAgent yes
    IdentityFile ${cfg.identity_file}
  '';
    };
  };
}

