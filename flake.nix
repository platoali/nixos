{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    #yazi.url = "github:sxyazi/yazi";
     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos  = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        
        ./configuration.nix
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.default 
        ./modules/main-user.nix
        ./modules/sshuttle.service.nix
        ./modules/rgb.service.nix
        ./modules/virt-manager.nix
        ./modules/mpd_custom_service.nix
    
#        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
