# Star Citizen game
{inputs, ...}: {
  nixosModules = [
    ({
      pkgs,
      lib,
      config,
      ...
    }: let
      cfg = config.my.star-citizen;
    in {
      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          inputs.nix-citizen.packages.${pkgs.system}.star-citizen
        ];
      };
    })
  ];
}
