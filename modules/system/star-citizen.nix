{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.star-citizen;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.star-citizen
    ];
  };
}
