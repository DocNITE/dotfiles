{ config, pkgs, ...}: {
  
  # Manage home manager itself
  # programs.home-manager.enable = true;

  # System shit
  home.username = "docnite";
  home.homeDirectory = "/home/docnite";

  # Home packages version
  home.stateVersion = "24.05";
}
