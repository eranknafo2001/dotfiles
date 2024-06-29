{ pkgs, lib, config, ... }:
let
  cfg = config.my.git;
in
{
  options.my.git = {
    enable = lib.mkEnableOption "git";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.eran = { config, pkgs, ... }:
      {
        programs.git = {
          enable = true;
          userName = "Eran Knafo";
          userEmail = "eranknafo2001@gmail.com";
          diff-so-fancy.enable = true;
          aliases = {
            co = "checkout";
            br = "brunch";
            st = "status";
          };
        };
      };
  };
}
