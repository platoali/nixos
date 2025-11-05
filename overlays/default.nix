{ config, pkgs, lib,inputs ,  ... }:

{
  nixpkgs.overlays = [
# (final: prev:  let
#     hyprlandGit = prev.hyprland.overrideAttrs (_: {
#       pname = "hyprland-git";
#       version = "git";
#       src = final.fetchgit {
#         url = "https://github.com/hyprwm/Hyprland.git";
#         fetchSubmodules = true;
#         sha256 = "CiKN7TRaCk3MF/FAwCMEO91TKFWS6bONhF8mhYPKhAU=";
#       };
#     });

#     # override hyprlandPlugins as a function of hyprland
#     hyprlandPlugins = prev.hyprlandPlugins // {
#       hyprscrolling = prev.hyprlandPlugins.hyprscrolling.overrideAttrs (_: {
#         buildInputs = [ hyprlandGit ];
#         HYPRLAND_HEADERS = "${hyprlandGit.dev}/include";
#         HYPRLAND_LIBS = "${hyprlandGit}/lib";
#         src = final.fetchgit {
#           url = "https://github.com/hyprwm/Hyprland-Plugins/hyprscrolling";
#           fetchSubmodules = true;
#         };
#         pname = "hyprscrolling-git";
#         version = "git";
#       });
#     };

#   in {
#     hyprland = hyprlandGit;

#   })
    

    
  ];
}
