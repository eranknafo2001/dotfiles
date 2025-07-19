{
  config,
  lib,
  ...
}: let
  cfg = config.my.nix-ld;
in {
  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
