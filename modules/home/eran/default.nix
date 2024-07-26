{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./kitty.nix
    ./discord.nix
    ./nvim/default.nix
    ./shell/default.nix
    ./hyprland/default.nix
  ];
  home.username = "eran";
  home.homeDirectory = "/home/eran";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
