{ pkgs, lib, config, inputs, ... }:
let cfg = config.my.solaar;
in {
  imports = [ inputs.solaar.nixosModules.default ];
  options.my.solaar = { enable = lib.mkEnableOption "solaar"; };
  config = lib.mkIf cfg.enable { services.solaar = { enable = true; }; };
}
