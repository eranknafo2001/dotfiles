{ pkgs, lib, config, ... }:
let
  cfg = config.my.shell;
in
{
  options.my.shell = {
    enable = lib.mkEnableOption "shell";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.eran = { config, pkgs, ... }:
      {
        home.packages = with pkgs; [
          xsel
          wget
          tmux
          file
          curl
          dust
        ];
        home.file.".config/starship.toml".source = ./starship.toml;
        programs = {
          fish.enable = true;
          fd.enable = true;
          feh.enable = true;
          jq.enable = true;
          ripgrep.enable = true;
          bat = {
            enable = true;
            extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
          };
          eza = {
            enable = true;
            git = true;
            icons = true;
          };
          starship = {
            enable = true;
            enableFishIntegration = true;
            enableBashIntegration = true;
          };
          nix-index = {
            enable = true;
            enableFishIntegration = true;
            enableBashIntegration = true;
          };
        };
      };
  };
}
