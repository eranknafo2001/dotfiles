{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.my.solaar;
in {
  imports = [inputs.solaar.nixosModules.default];
  config = lib.mkIf cfg.enable {services.solaar.enable = true;};
}
