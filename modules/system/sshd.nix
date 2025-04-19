{
  lib,
  config,
  ...
}: let
  cfg = config.my.sshd;
in {
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };
  };
}
