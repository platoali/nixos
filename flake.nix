{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland-src.url = "github:hyprwm/Hyprland";
    # hyprland-protocols-src.url ="github:hyprwm/hyprland-protocols" ;
    # hyprland-plugins-src.url = "github:hyprwm/hyprland-plugins";

    # # Optional: follow Hyprland source for plugin’s dependency
    # hyprland-plugins-src.inputs.hyprland.follows = "hyprland-src";
        
  };

  outputs = { self, nixpkgs,   ... }@inputs: 
     {
      nixosConfigurations.nixos  = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
    
        modules = [
          (import ./overlays) 
          ./configuration.nix
          ./hardware-configuration.nix
          inputs.home-manager.nixosModules.default
          ./modules/main-user.nix
          ./modules/sshuttle.service.nix
          ./modules/rgb.service.nix
          ./modules/virt-manager.nix
          ./modules/mpd_custom_service.nix
        ];
      };
    };
  
}
