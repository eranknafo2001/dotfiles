{ pkgs, lib, config, ... }:
let
  cfg = config.my.kitty;
in
{
  options.my.kitty = {
    enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.eran = { config, pkgs, ... }:
      {
        programs.kitty = {
          enable = true;
          font = {
            name = "Hack Nerd Font";
            package = (pkgs.nerdfonts.override { fonts = [ "Hack" ]; });
          };
          settings = {
            shell = "${pkgs.fish}/bin/fish";
          };
        };
      };
  };
}
