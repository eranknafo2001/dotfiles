# Solaar - Logitech device management
{inputs, ...}: {
  nixosModules = [
    inputs.solaar.nixosModules.default
    ({lib, config, ...}: let
      cfg = config.my.solaar;
    in {
      config = lib.mkIf cfg.enable {
        services.solaar.enable = true;
      };
    })
  ];
}
